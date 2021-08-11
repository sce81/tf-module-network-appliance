resource "aws_instance" "main" {
  ami                                   = var.ami_id
  instance_type                         = var.instance_type
  disable_api_termination               = var.disable_api_termination 
  key_name                              = var.key_name
  user_data                             = var.user_data
  iam_instance_profile                  = var.instance_profile

  network_interface {
    network_interface_id                = aws_network_interface.public.id
    device_index                        = 0
  }

  network_interface {
    network_interface_id                = aws_network_interface.management.id
    device_index                        = 1
  }

  network_interface {
    network_interface_id                = aws_network_interface.private.id
    device_index                        = 2
  }

  tags = merge(
        local.common_tags, var.extra_tags,
        tomap({
            Name = "${var.env}-${var.project}-${var.name}-${var.number}"
        })
    )

  lifecycle {
    ignore_changes                     = [user_data]
  }
}

resource "aws_network_interface" "public" {
  subnet_id                             = element(var.pub_subnet_ids, var.number)
  security_groups                       = var.pub_security_group_ids
  source_dest_check                     = var.pub_source_dest_check
  
  tags = merge(
        local.common_tags, var.extra_tags,
        tomap({
            Name = "${var.env}-${var.project}-${var.name}-public-${var.number}"
        })
    )

}
resource "aws_network_interface" "management" {
  subnet_id                             = element(var.mgmt_subnet_ids, var.number)
  security_groups                       = var.mgmt_security_group_ids
  source_dest_check                     = var.mgmt_source_dest_check
  
  tags = merge(
        local.common_tags, var.extra_tags,
        tomap({
            Name = "${var.env}-${var.project}-${var.name}-management-${var.number}"
        })
    )
}
resource "aws_network_interface" "private" {
  subnet_id                             = element(var.priv_subnet_ids, var.number)
  security_groups                       = var.priv_security_group_ids
  source_dest_check                     = var.priv_source_dest_check
  
  tags = merge(
        local.common_tags, var.extra_tags,
        tomap({
            Name = "${var.env}-${var.project}-${var.name}-private-${var.number}"
        })
    )
}

resource "aws_eip" "public" {
  vpc                                   = true
  customer_owned_ipv4_pool              = var.customer_owned_ipv4_pool
  network_interface                     = aws_network_interface.public.id

  tags = merge(
        local.common_tags, var.extra_tags,
        tomap({
            Name = "${var.env}-${var.project}-${var.name}-eip-${var.number}"
        })
    )
  depends_on = [
    aws_instance.main
  ]
}
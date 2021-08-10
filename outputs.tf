output "public_eni" {
    value = aws_network_interface.public.id
}
output "mgmt_eni" {
    value = aws_network_interface.management.id
}
output "private_eni" {
    value = aws_network_interface.private.id
}
output "public_ip"  {
    value = aws_eip.public.public_ip
} 
output "mgmt_ip"    {
    value = aws_network_interface.management.private_ips
}
output "private_ip" {
    value = aws_network_interface.private.private_ips
}
output "instance_id" {
    value = aws_instance.main.id
}
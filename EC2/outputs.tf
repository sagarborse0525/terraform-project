#Outputs values

output "ec2_instance_public_ip" {
  description = "EC2 Instance public IP"
  value = aws_instance.ec2.*.public_ip
}

output "ec2_instance_private_ip" {
  description = "EC2 instance private IP"
  value = aws_instance.ec2.*.private_ip
}

output "ec2_security_group" {
  description = "List security group associated with EC2 instance"
  value = aws_instance.ec2.*.security_groups
}

output "ec2_public_dns" {
  description = "Public DNS URL of an EC2 instance"
  value = aws_instance.ec2.*.public_dns
}
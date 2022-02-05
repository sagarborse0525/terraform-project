# Create EC2 instance
resource "aws_instance" "ec2" {
    ami = var.images["centos7"]
    instance_type = var.instance_type
    key_name = var.key_name
    user_data = file("apache-install.sh")
    #user_data = var.ec2_user_datas
    availability_zone = var.availability_zone["0"]
    count = var.ec2_count
    subnet_id = var.subnet_id["0"]
    vpc_security_group_ids = [var.ec2_sg["0"]]

    tags = {
        "Name" = var.tags["Name"]
        "Env"  = var.tags["Env"]
        "CreatedBy" = var.tags["CreatedBy"]
    }
}
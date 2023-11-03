# Get Latest AWS AMI ID for Amazon2 Linux
data "aws_ami" "Latest_Image" {
  most_recent = true
  owners      = ["099720109477"]
  # image name
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  # root device type
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  # virtualization-type
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

output "ami_id" {
  value = data.aws_ami.Latest_Image.id

}


resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_key_pair" "key_tf" {
  key_name   = "ec2keypair2"   # Replace with your desired key pair name   
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC620P8XJxouf6aqBWtiGr5UR57dIJ7xGqd5BHSwPTN/YVWmz4hGoThpr1Vum2tF3nmZkjSebBqUADIHuO0lr/JhIcWo3g7duPbtZUjQBanJUM+AxmKy2ACZ+uXDtCc6c1yY65PT2+bW1CQuduEGpnduRa/pgf47ylrDJ81Se6WUTJN4SCk+noUC5ncz5JGz3sQ4PZtSJW3dMbVKYnwsSMLf50uAbtwuSTiqu6vkBvml9omrsnYCNnBnEb3uMHJNoQQtdo2O35ANe+nTFHmjTXxq3yBQti+GDGxLEqaLwOWIp1xZtMk+A9EC+jaYbB2gFcASXSxG0MpQyjSwSAQgARBN2eJ8FycPAnCjaAPptF8++HWyBwcvtm8VfvchDMwgu52ClA+ki1HF7iYpescra9Q0QzYjY6O7wfjMbx1FE6vxJJefcbGnPFBBdQrBSZuUxzdlmxpeuGYoIOUxkqAPTeR7pi/Rgu5xiDkR2hhp/87N11+/t/6i4x26ML74kU+9y0= gauravkeshri@Gaurav-Macs-Air" 
  public_key = file("${path.module}/id_ec2.pub")
  }


output "keyname" {
value = "${aws_key_pair.key_tf.key_name}"
}

 resource "aws_security_group" "allow_tls" {
   name        = "allow_tls"
  description = "Allow TLS inbound traffic"
   vpc_id      = "${aws_vpc.example.id}"

   ingress {
     description = "TLS from VPC"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["10.0.1.0/24"]
   }
 ingress {
     description = "TLS from VPC"
     from_port   = 22
     to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
 }  
resource "aws_instance" "web" {
   ami           = "ami-09e14f3154e091177"
   instance_type = "t2.micro"
  subnet_id     = aws_subnet.example.id
   vpc_security_group_ids = [aws_security_group.allow_tls.id]
   key_name = "${aws_key_pair.key_tf.key_name}"
   tags = {
     Name = "ExampleInstance"


   }
provisioner "file" {
    source      = "local/path/to/your/file.txt"
    destination = "/path/on/ec2/instance/file.txt"
  }
   user_data = <<-EOT
     <powershell>
     net user exampleuser Password123! /add
     net localgroup Administrators exampleuser /add
     </powershell>
     EOT
 }
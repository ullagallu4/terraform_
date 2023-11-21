data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_availability_zones" "available" {
    state = "available"
}
resource "aws_instance" "instane-AL3" {
  for_each = {
    "subnet1" = var.public_subnets_ids[0]
    "subnet2" = var.public_subnets_ids[1]
    "subnet3" = var.public_subnets_ids[2]
    # Add more keys if needed
  }
  ami             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = each.value
  security_groups = var.sg_id
  availability_zone = data.aws_availability_zones.available.names[index(var.public_subnets_ids, each.value)]
  user_data = <<EOF
  #!/bin/bash
    sudo dnf update -y
    sudo dnf install -y httpd
    sudo dnf install -y git
    export META_INST_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
    export META_INST_TYPE=`curl http://169.254.169.254/latest/meta-data/instance-type`
    export META_INST_AZ=`curl http://169.254.169.254/latest/meta-data/placement/availability-zone`
    cd /var/www/html
    echo "<!DOCTYPE html>" >> index.html
    echo "<html lang="en">" >> index.html
    echo "<head>" >> index.html
    echo "    <meta charset="UTF-8">" >> index.html
    echo "    <meta name="viewport" content="width=device-width, initial-scale=1.0">" >> index.html
    echo "    <style>" >> index.html
    echo "        @import url('https://fonts.googleapis.com/css?family=Open+Sans&display=swap');" >> index.html
    echo "        html {" >> index.html
    echo "            position: relative;" >> index.html
    echo "            overflow-x: hidden !important;" >> index.html
    echo "        }" >> index.html
    echo "        * {" >> index.html
    echo "            box-sizing: border-box;" >> index.html
    echo "        }" >> index.html
    echo "        body {" >> index.html
    echo "            font-family: 'Open Sans', sans-serif;" >> index.html
    echo "            color: #324e63;" >> index.html
    echo "        }" >> index.html
    echo "        .wrapper {" >> index.html
    echo "            width: 100%;" >> index.html
    echo "            width: 100%;" >> index.html
    echo "            height: auto;" >> index.html
    echo "            min-height: 90vh;" >> index.html
    echo "            padding: 50px 20px;" >> index.html
    echo "            padding-top: 100px;" >> index.html
    echo "            display: flex;" >> index.html
    echo "        }" >> index.html
    echo "        .instance-card {" >> index.html
    echo "            width: 100%;" >> index.html
    echo "            min-height: 380px;" >> index.html
    echo "            margin: auto;" >> index.html
    echo "            box-shadow: 12px 12px 2px 1px rgba(13, 28, 39, 0.4);" >> index.html
    echo "            background: #fff;" >> index.html
    echo "            border-radius: 15px;" >> index.html
    echo "            border-width: 1px;" >> index.html
    echo "            max-width: 500px;" >> index.html
    echo "            position: relative;" >> index.html
    echo "            border: thin groove #9c83ff;" >> index.html
    echo "        }" >> index.html
    echo "        .instance-card__cnt {" >> index.html
    echo "            margin-top: 35px;" >> index.html
    echo "            text-align: center;" >> index.html
    echo "            padding: 0 20px;" >> index.html
    echo "            padding-bottom: 40px;" >> index.html
    echo "            transition: all .3s;" >> index.html
    echo "        }" >> index.html
    echo "        .instance-card__name {" >> index.html
    echo "            font-weight: 700;" >> index.html
    echo "            font-size: 24px;" >> index.html
    echo "            color: #6944ff;" >> index.html
    echo "            margin-bottom: 15px;" >> index.html
    echo "        }" >> index.html
    echo "        .instance-card-inf__item {" >> index.html
    echo "            padding: 10px 35px;" >> index.html
    echo "            min-width: 150px;" >> index.html
    echo "        }" >> index.html
    echo "        .instance-card-inf__title {" >> index.html
    echo "            font-weight: 700;" >> index.html
    echo "            font-size: 27px;" >> index.html
    echo "            color: #324e63;" >> index.html
    echo "        }" >> index.html
    echo "        .instance-card-inf__txt {" >> index.html
    echo "            font-weight: 500;" >> index.html
    echo "            margin-top: 7px;" >> index.html
    echo "        }" >> index.html
    echo "    </style>" >> index.html
    echo "    <title>Amazon EC2 Status</title>" >> index.html
    echo "</head>" >> index.html
    echo "<body>" >> index.html
    echo "    <div class="wrapper">" >> index.html
    echo "        <div class="instance-card">" >> index.html
    echo "            <div class="instance-card__cnt">" >> index.html
    echo "                <div class="instance-card__name">Your EC2 Instance is running!</div>" >> index.html
    echo "                <div class="instance-card-inf">" >> index.html
    echo "                    <div class="instance-card-inf__item">" >> index.html
    echo "                        <div class="instance-card-inf__txt">Instance Id</div>" >> index.html
    echo "                        <div class="instance-card-inf__title">" $META_INST_ID "</div>" >> index.html
    echo "                    </div>" >> index.html
    echo "                    <div class="instance-card-inf__item">" >> index.html
    echo "                        <div class="instance-card-inf__txt">Instance Type</div>" >> index.html
    echo "                        <div class="instance-card-inf__title">" $META_INST_TYPE "</div>" >> index.html
    echo "                    </div>" >> index.html
    echo "                    <div class="instance-card-inf__item">" >> index.html
    echo "                        <div class="instance-card-inf__txt">Availability zone</div>" >> index.html
    echo "                        <div class="instance-card-inf__title">" $META_INST_AZ "</div>" >> index.html
    echo "                    </div>" >> index.html
    echo "                </div>" >> index.html
    echo "            </div>" >> index.html
    echo "        </div>" >> index.html
    echo "</body>" >> index.html
    echo "</html>" >> index.html
    sudo service httpd start
  EOF
  tags = {
    Name = var.names[each.key]
  }
}





  
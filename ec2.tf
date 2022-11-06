resource "aws_key_pair" "admin" {
  key_name   = "admin"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCd3eRqmsplPsQfbPhkfZ5EHOzSYWP/ydGeJO5lGUpLw7kBWzo1WiDgMXqG3ldAUNwzmoTZviyvcmQjNkOiYV0/U2aKV8GH+ARtLVPzef3V/1kxpEuYm6vlswxhZdve1aZKfuLCWWePnJX/hwp9NqUHXYApxYWDRKaKb0urds+YiJJUzh6UdqBnSjoa/X9f1sfjs1jsEE6aJdqhknV4RvFREgWn4RO9SlWjKT7Mx+k1E5UFFjHWgo0Oqubb/nT3YqWDTwnDGQ7s1Ppv5bODtmClTi3Zk6oACvr60q55p5zIizH2rPWPYqoA1RIAnSEgPjQp6/7TXkX+1im7JiEBZtgD7POgyrsWm9jhzI7yF3KzDan1u2NLtuVm5QCTTp2l0jiOXfwgqPHi6BgqE5w4Iihvt0mDwIVCQuCQ2jHcbUyII9wMnl1JtXIu2oMlXwr9Xf7V2pxy864VST2kSNyLLiLwNh1ymQco5Gj+tYUNsSDEWACS6862UaAzyi+hnng7EZc= quentin@tardis"
}

resource "aws_instance" "app_timeo" {
  ami                    = "ami-045fa58af83eb0ff4"
  instance_type          = "t2.micro"
  key_name               = "admin"
  vpc_security_group_ids = ["public_sg.id"]

  user_data = <<EOF
  #!/bin/bash
  echo "Installing docker"
  apt update
  apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
  apt update
  apt install docker-ce -y
  docker run -p 5000:5000 -d gastbob40/devops
  EOF
}

resource "alicloud_dns_record" "record" {
    name = "devops.site" //zone名称
    host_record = "demo" //主机记录
    type = "A" //记录类型
    value = "123.123.123" //记录值
}

//vpc专有网络
resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf-test"
  cidr_block = "172.80.0.0/12"
}

//switch交换机
resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.80.0.0/21"
  zone_id    = "cn-beijing-b"
}

//security_group 安全组
resource "alicloud_security_group" "group" {
  name                = "demo-group"
  vpc_id              = alicloud_vpc.vpc.id
  security_group_type = "normal" //普通类型
}

//security_group_rule 规则
resource "alicloud_security_group_rule" "allow_80_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

//security_group_rule 规则
resource "alicloud_security_group_rule" "allow_22_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}
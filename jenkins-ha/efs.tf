resource "aws_efs_file_system" "JenkinsEFS" {
  creation_token   = "Jenkins-EFS"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "JenkinsHomeEFS"
  }
}

resource "aws_efs_mount_target" "efs-mt-jenkins" {
  count           = length(tolist(data.aws_subnet_ids.default.ids))
  file_system_id  = aws_efs_file_system.JenkinsEFS.id
  subnet_id       = element(tolist(data.aws_subnet_ids.default.ids), count.index)
  security_groups = [aws_security_group.ingress-efs.id]
}

output "efs_dns_name" {
  value = aws_efs_file_system.JenkinsEFS.dns_name
}
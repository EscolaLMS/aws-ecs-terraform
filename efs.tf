resource "aws_efs_file_system" "efs" {
   creation_token = "efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 }

resource "aws_efs_mount_target" "efs-mt" {
   count = length(module.Networking.public_subnets_id)
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = module.Networking.public_subnets_id[count.index]
   security_groups = [aws_security_group.efs.id]
 }
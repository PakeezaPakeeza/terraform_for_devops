# data "aws_secretsmanager_secret" "db_secret" {
#   name = "test-db-password"
# }
# data "aws_secretsmanager_secret_version" "db_secret_version" {
#   secret_id = aws_secretsmanager_secret.db_secret.id
# }

# #Deploying RDS MySQL Instance
# #Create a subnet group
# resource "aws_db_subnet_group" "test_subnet_group" {
#   name = "test-db-subnet-group"
#   subnet_ids = [
#     aws_subnet.subnet1-public.id,
#     aws_subnet.subnet2-public.id,
#   ]
#   tags = {
#     Name = "My test DB subnet group"
#   }
# }

# #Deploy the RDS instance:
# resource "aws_db_instance" "test_db_instance" {
#   identifier           = "testdb"
#   allocated_storage    = 10
#   engine               = "mysql"
#   engine_version       = "8.0.39"
#   instance_class       = "db.t3.medium"
#   db_name              = "test_db"
#   username             = "dbadmin"
#   password             = data.aws_secretsmanager_secret_version.db_secret_version.secret_string
#   publicly_accessible  = true
#   db_subnet_group_name = aws_db_subnet_group.test_subnet_group.id
# }
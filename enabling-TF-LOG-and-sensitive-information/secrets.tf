#Generate a random password:
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}
#Store the password in AWS Secrets Manager:
resource "aws_secretsmanager_secret" "db_secret" {
  name = "test-db-password"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = random_password.db_password.result
}
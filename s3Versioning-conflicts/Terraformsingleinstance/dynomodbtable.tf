resource "aws_dynamodb_table" "state_locking" {
  name           = "dynamodb-state-locking"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
   # Environment = "Production"
  }
}

# Temporarily Disable State Locking
# Since the table is required for state locking and is missing, you need to disable locking while Terraform creates the table.

# Run the following command:
# terraform apply -lock=false
# This ensures Terraform applies the configuration without attempting to acquire a state lock.
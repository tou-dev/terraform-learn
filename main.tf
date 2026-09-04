terraform {
  required_version = ">= 1.10.0"
}

# Example using a local file resource to trigger a local shell command
resource "local_file" "foo" {
  content  = "Hello, Terraform Local Exec!"
  filename = "${path.module}/foo.txt"

  # Executes a command on the machine running Terraform after creation
  provisioner "local-exec" {
    command = "echo 'Created file with content: ${self.content}'"
  }

  # Executes a command on the machine running Terraform before destruction
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'About to delete file: ${self.filename}'"
  }
}

# Example using terraform_data (recommended modern approach over null_resource)
resource "terraform_data" "run_script" {
  triggers_replace = [
    local_file.foo.id
  ]

  provisioner "local-exec" {
    command     = "echo 'Triggered script execution locally!'"
    working_dir = path.module
    environment = {
      FILE_PATH = local_file.foo.filename
    }
  }
}
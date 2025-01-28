
# Terraform Logging with TF_LOG Variables

Terraform provides the `TF_LOG` environment variable to control the logging level of Terraform commands. This is helpful for debugging and troubleshooting issues in your Terraform configurations.

---

## **TF_LOG Levels**
The `TF_LOG` variable determines the verbosity of Terraform's output logs. Here are the available levels:

| Level   | Description                                                                 |
|---------|-----------------------------------------------------------------------------|
| TRACE   | Most detailed logs, includes internal details and sensitive information.   |
| DEBUG   | Debug-level information for troubleshooting.                               |
| INFO    | General information about Terraform operations.                            |
| WARN    | Warnings about potential issues that don't stop execution.                 |
| ERROR   | Errors that may stop execution or require immediate attention.             |

---

## **Setting TF_LOG**
To enable logging, set the `TF_LOG` variable to the desired level in your terminal or shell.

### Example:
```bash
export TF_LOG=DEBUG
```

### For PowerShell (Windows):
```powershell
$env:TF_LOG="TRACE"
$env:TF_LOG_PATH="terraform.txt"
```
Now close and reopen the console and type the following to verify that it worked:
```powershell
> echo $env:TF_LOG
TRACE
> echo $env:TF_LOG_PATH
terraform.txt
```

---

## **Redirecting Logs to a File**
By default, logs are displayed in the terminal. To save logs to a file, use the `TF_LOG_PATH` environment variable.

### Example:
```bash
export TF_LOG=DEBUG
export TF_LOG_PATH="./logs/terraform_debug.log"
mkdir -p logs
terraform apply
```
This will write the logs to `./logs/terraform_debug.log`.

---

## **Disabling TF_LOG**
To disable logging, unset the `TF_LOG` variable.

### Command:
```bash
unset TF_LOG
```

### For PowerShell (Windows):
```powershell
Remove-Item Env:TF_LOG
```

---

## **Temporary Logging**
You can enable logging temporarily for a single Terraform command by prefixing it with the `TF_LOG` variable.

### Example:
```bash
TF_LOG=TRACE terraform plan
```

---

## **Verifying Active TF_LOG**
To check if the `TF_LOG` variable is set:
```bash
echo $TF_LOG
```
If no value is returned, the variable is not set.

---

## **Best Practices**
1. Use `TRACE` or `DEBUG` levels only for troubleshooting, as they generate detailed and sensitive logs.
2. Always redirect logs to a file for easier analysis.
3. Remember to unset `TF_LOG` after debugging to avoid excessive log output.

---

This document provides a quick reference to effectively use Terraform logging with `TF_LOG`. Let me know if you need further assistance!

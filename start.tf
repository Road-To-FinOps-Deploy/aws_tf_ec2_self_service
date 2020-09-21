
data "archive_file" "bastion_start_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/bastion_start.py"
  output_path = "${path.module}/output/bastion_start.zip"
}

resource "aws_lambda_function" "bastion_start" {

  filename         = "${path.module}/output/bastion_start.zip"
  function_name    = "${var.function_prefix}_bastion_start"
  role             = "${aws_iam_role.iam_role_for_bastion_start_stop.arn}"
  handler          = "bastion_start.lambda_handler"
  source_code_hash = "${data.archive_file.bastion_start_zip.output_base64sha256}"
  runtime          = "python3.7"
  memory_size      = "512"
  timeout          = "150"
}


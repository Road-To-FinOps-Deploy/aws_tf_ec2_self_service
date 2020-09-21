#Generating the zip files
data "archive_file" "bastion_stop_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/bastion_stop.py"
  output_path = "${path.module}/output/bastion_stop.zip"
}


resource "aws_lambda_function" "bastion_stop" {
  count            = "${var.costsave}"
  filename         = "${path.module}/output/bastion_stop.zip"
  function_name    = "${var.function_prefix}_bastion_stop"
  role             = "${aws_iam_role.iam_role_for_bastion_start_stop.arn}"
  handler          = "bastion_stop.lambda_handler"
  source_code_hash = "${data.archive_file.bastion_stop_zip.output_base64sha256}"
  runtime          = "python3.7"
  memory_size      = "512"
  timeout          = "150"
}


resource "aws_lambda_permission" "allow_cloudwatch_bastion_stop" {
  count            = "${var.costsave}"
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.bastion_stop.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.bastion_stop_cloudwatch_rule.arn}"

  depends_on = ["aws_lambda_function.bastion_stop"]
}


resource "aws_cloudwatch_event_rule" "bastion_stop_cloudwatch_rule" {
  count            = "${var.costsave}"
  name = "bastion_stop_lambda_trigger"

  #to be run between 1-4am every 3 months starting from Feb on the first sunday of the month

  schedule_expression = "${var.ec2_stop_cron}"
}

resource "aws_cloudwatch_event_target" "bastion_stop_lambda" {
  count            = "${var.costsave}"
  rule      = "${aws_cloudwatch_event_rule.bastion_stop_cloudwatch_rule.name}"
  target_id = "lambda_target"
  arn       = "${aws_lambda_function.bastion_stop.arn}"
}

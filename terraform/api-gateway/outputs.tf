output "api_gateway_url" {
  value = "${aws_apigatewayv2_api.api_gateway.api_endpoint}/${aws_apigatewayv2_stage.stage.name}"
}
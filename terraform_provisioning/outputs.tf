output "address" {
  value = "${aws_instance.test_machine.public_ip}"
}

output "list-instances-ip-test" {
    value = data.aws_instances.test.public_ips
}
output "amount-instances-test" {
    value = length(data.aws_instances.test.ids)
}

output "list-instances-ip-prod" {
    value = data.aws_instances.prod.public_ips
}
output "amount-instances-prod" {
    value = length(data.aws_instances.prod.ids)
}

output "list-instances-ip-all" {
    value = data.aws_instances.general.public_ips
}
output "amount-instances-all" {
    value = length(data.aws_instances.general.ids)
}

output "current-instance-ip-test" {
    value = data.aws_instances.test.public_ips[length(data.aws_instances.test.ids) - 1]
}



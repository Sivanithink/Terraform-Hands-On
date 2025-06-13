output "nithin_web_server_public_ip" {
  value       = module.my_web_server.public_ip
  description = "Public IP of the web server launched via module"
}

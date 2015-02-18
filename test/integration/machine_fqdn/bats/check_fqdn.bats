@test "check hostname and fqdn" {
  [ `hostname` == 'working' ] && [ `hostname -f` == 'working.computers.biz' ]
}

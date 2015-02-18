@test "check hostname and fqdn" {
  [ `hostname` == 'working.computers.biz' ] && [ `hostname -f` == 'working.computers.biz' ]
}

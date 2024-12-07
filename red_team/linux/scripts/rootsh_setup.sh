while read line
do
    if [[$line==*"fedora"*]]
    then
        echo $line
    fi
done < /etc/os-release
if [ -f "/etc/default/useradd" ]; then
  echo "File exists"
else
  echo "File does not exist"
fi
path=$1
date;for intercept in `cat /etc/hosts | awk 'NR > 5' | grep in |  awk {'print $2'} | grep -v 4 | sort`;
do
        echo "=========================  $intercept  =====================";
        ssh $intercept "python /home/fdsadmin/scripts/check_calls.py $path"
done

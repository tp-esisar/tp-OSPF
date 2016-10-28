
%: conf/%/*
	echo "MAJ de $^"
	sshpass -p 'root' scp -o StrictHostKeyChecking=no $^ root@$@:/etc/quagga/
	sshpass -p 'root' ssh -o StrictHostKeyChecking=no root@$@ '/etc/init.d/S27quagga restart'



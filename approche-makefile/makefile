pop1r=pop1r1 pop1r2
pop1bk=pop1bk1 pop1bk2
pop1=$(pop1r) $(pop1bk)
test:
	echo $(pop1)

grp-pop1: $(addprefix lock/,$(pop1))
	echo yolo

lock/%: conf/%
	echo "MAJ de $<"
	cp -r -u $< lock

%: conf/%/*
	echo "MAJ de $<"
	cp -r -u $^ lock/$@/
	sshpass -p 'root' scp $^ root@$@:/etc/quagga/
	sshpass -p 'root' ssh root@$@ '/etc/init.d/quagga restart'



Vagrant.configure("2") do |config|

  config.vm.box = "debian/jessie64"

  config.vm.define "node1" do |machine|
    machine.vm.network "private_network", ip: "172.17.177.21"
    machine.vm.provision :ansible do |ansible|
      ansible.inventory_path = "vagrant/hosts.ini"
      ansible.playbook       = "vagrant.yml"
    end
  end

  # config.vm.define "node2" do |machine|
    # machine.vm.network "private_network", ip: "172.17.177.22"
  # end

  # config.vm.define 'controller' do |machine|
  #   machine.vm.network "private_network", ip: "172.17.177.11"

  #   machine.vm.provision :ansible do |ansible|
  #     ansible.playbook       = "playbook.yml"
  #     ansible.verbose        = "vvvv"
  #     #ansible.install        = true
  #     #ansible.limit          = "all" # or only "nodes" group, etc.
  #     ansible.inventory_path = "inventory"
  #     ansible.raw_arguments  = ["--connection=paramiko",
  #       "--private-key=/vagrant/node1_key"]
  #     #ansible.extra_vars = { ansible_ssh_user: 'vagrant', ansible_ssh_pass: 'vagrant'}
  #   end
  # end

end

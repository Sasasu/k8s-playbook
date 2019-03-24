. env.fish

for i in $ALL_VM
      ssh $i "sudo reboot"
end


. env.fish

for i in $ALL_VM
      ssh $i "$argv"
end


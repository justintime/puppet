Facter.add("localmounts") do
  confine :kernel => :linux
  mountpoint = nil;
  localmounts = []
  setcode do
    File.open("/proc/mounts").each do |line|
      mountpoint = $1 if line =~ /^\/dev\S+\s+(\S+)\s+/
      if mountpoint != nil 
        localmounts.push(mountpoint)
        mountpoint = nil
      end
    end    
    localmounts.join(',')
  end
end

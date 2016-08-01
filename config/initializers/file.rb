require 'socket' # For querying IP and MAC
require 'etc' # for querying filesystem

class File

  def getMACandIPaddresses
    # With socket parsing 
    #2.2.4 :024 > interfaces.first.addr.inspect_sockaddr.split[1]
    # => "lo"
    #2.2.4 :025 > interfaces.first.addr.inspect_sockaddr.split[4]
    # => "hwaddr=00:00:00:00:00:00]"
    #2.2.4 :026 > interfaces.first.addr.inspect_sockaddr.split[4][/hwaddr=([\h:]+)/, 1]
    # => "00:00:00:00:00:00" 

    osNetworkDataObject = {}
    osNetworkDataObject['hostname'] = Socket.gethostname
    Socket.getifaddrs.each do |ifaddr|
      if ifaddr.addr.ip?
        if !osNetworkDataObject[ifaddr.name]
          osNetworkDataObject[ifaddr.name] = []
        end

       # $stderr.puts "ifaddr.name (before process): #{ifaddr.name}"

        if ifaddr.addr.ipv6? && !ifaddr.name.include?("utun")
          osNetworkDataObject[ifaddr.name].push({ipv6: ifaddr.addr.ip_address})
        elsif ifaddr.addr.ipv4? && !ifaddr.name.include?("utun")
          osNetworkDataObject[ifaddr.name].push({ipv4: ifaddr.addr.ip_address})
        else
          #IP Address not valid
        end
      end

      if !ifaddr.name.include?("utun") #utun interfaces take too long to query. Skip them.
       # $stderr.puts "This says that 'utun' is not part of the name: #{ifaddr.name}"
        if Socket.const_defined? :PF_LINK
          if !osNetworkDataObject[ifaddr.name]
            osNetworkDataObject[ifaddr.name] = []
          end
          # $stderr.puts "ifaddr.name: #{ifaddr.name}"
          if address = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/.match(ifaddr.addr.getnameinfo[0])
            osNetworkDataObject[ifaddr.name].push({hwaddr: address.to_s})
          end
        elsif Socket.const_defined? :PF_PACKET
          if interfaceName = ifaddr.addr.inspect_sockaddr.split[1]
            if !osNetworkDataObject[interfaceName]
              osNetworkDataObject[interfaceName] = []
            end
            osNetworkDataObject[interfaceName].push({hwaddr: ifaddr.addr.inspect_sockaddr.split[4][/hwaddr=([\h:]+)/, 1]})
          end
        end
      #$stderr.puts "ifaddr.name (after process): #{ifaddr.name}"

      end
    end
    return osNetworkDataObject
  end


  def getOSMetaDataObject
  if File.file?(self)
    osMetaDataObject = {}
    # Get atime, mtime, etc
    osMetaDataObject['originalFilename'] = File.basename(self)
    osMetaDataObject['originalFileSizeInBytes'] = self.size

    if OS.mac?
      originalFileBestGuessCreationTime = Time.parse(`mdls -name kMDItemContentCreationDate -raw "#{File.absolute_path(self)}"`) #OSX only
      osMetaDataObject['originalFileBestGuessCreationTime'] = originalFileBestGuessCreationTime.to_f
    else
      osMetaDataObject['originalFileBestGuessCreationTime'] = File.ctime(self).to_f
    end
    osMetaDataObject['originalFileCTime'] = File.ctime(self).to_f
    osMetaDataObject['originalFileMTime'] = File.mtime(self).to_f
    osMetaDataObject['originalFileATime'] = File.atime(self).to_f
    # Get path including filename
    osMetaDataObject['originalFileAbsolutePath'] = File.absolute_path(self)
    # Get path excluding filename. Follows Jekyll convention of leaving off trailing slashes and adding them to the beeginning of the next variable
    osMetaDataObject['originalFileDirName'] = File.dirname(self)
    # get permissions
    osMetaDataObject['originalFilePermissions'] = File.stat(self).mode.to_s(8)
    # Get user and group
    if fileuid = File.stat(self).uid
     # $stderr.puts "Getting usernames"
      osMetaDataObject['originalFileOwner'] = Etc.getpwuid(fileuid)[:name]
     # $stderr.puts "Getting groups"
      osMetaDataObject['originalFileOwnerFullName'] = Etc.getpwuid(fileuid)[:gecos]
     # $stderr.puts "Done getting usernames/groups"
    end
    if filegroupid = File.stat(self).gid
     osMetaDataObject['originalFileGroup'] = Etc.getgrgid(filegroupid)[:name]
    end
    # Get hostname
    osMetaDataObject['ingestDeviceHostname'] = Socket.gethostname
    # Get IP/MAC as an array (all devices could have more than 1, might as well assume so we don't have to test for an array later)
    osMetaDataObject['ingestDeviceNetworking'] = getMACandIPaddresses
#    osMetaDataObject['macAddresses'] = #GIANT MESS WHY? Now handled in the giant function above
    # Get OS version
    osMetaDataObject['ingestDeviceOperatingSystemVersion'] = `uname -v`.strip
    
    # Get location?
    # Confidences
    # If some data is not gettable, leave it blank; no error neccessary in production
    return osMetaDataObject #Is a root-level object that can be assigned as file['origional'] = getOSMetaData 

    # Quick tips: JSON.pretty_generate(File.new("/home/josh/.bashrc").getOSMetaDataObject) #in Rails, pretty_generate wants the object, not the JSON
  else # after checking if file? is true
    return false, "#{File.absolute_path(self)} is not a file. Maybe it's a directory?"
  end # end after checking if file? is true
  end
end

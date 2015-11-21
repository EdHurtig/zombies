#!/usr/bin/env ruby

require 'aws-sdk-v1'
require 'colorize'

AWS.config(
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
if ARGV.any?
  security_group = ARGV[0]
elsif ENV['AWS_TESTING_SECURITY_GROUP']
  security_group = ENV['AWS_TESTING_SECURITY_GROUP']
else
  security_group = 'ci-testing'
end

puts "Searching for Instances in the '#{security_group}' security group"

ec2 = AWS::EC2.new

begin
  instances = ec2.security_groups.filter('group-name', security_group).first.instances
rescue Exception => e
  puts "Could Not Connect to AWS: #{e.message}".red
  exit
end
puts "Discovered #{instances.count} Test Instances.\n"
i = 0
stoppable = []
instances.each do |instance|
  i += 1
  line = " #{i}. #{instance.id} : #{instance.tags.Name} : #{instance.status}"
  if instance.status == :terminated
    puts line.red
  elsif instance.status == :running
    puts line.green
    stoppable << instance
  else
    puts line.yellow
  end
end
puts ''
if stoppable.any?
  stoppable.each do |instance|
    puts "Instance #{instance.id} (#{instance.tags.Name}) is #{instance.status}."
    print 'Would you like to terminate it? [yN]'
    if 'y' == gets.chomp
      print "Are you absolutely sure you wish to terminate instance #{instance.id} (#{instance.tags.Name}) [yN]".red
      if  'y' == gets.chomp
        puts "Terminating Instance #{instance.id} (#{instance.tags.Name})"
        instance.terminate
        system 'dragon'
      else
        puts 'Ok, Won\'t Terminate Instance'.green
      end
    else  
      puts 'Ok, Won\'t Terminate Instance'.green
    end
  end
end
puts 'Zombie Checking Complete'

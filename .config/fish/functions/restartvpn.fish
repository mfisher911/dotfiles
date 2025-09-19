function restartvpn --wraps='launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp* && launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*' --description 'alias restartvpn=launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp* && launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*'
  launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp* && launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp* $argv
        
end

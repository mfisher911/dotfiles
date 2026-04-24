function restartvpn --description 'restart GlobalProtect VPN services'
  launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp* && \
    launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
end

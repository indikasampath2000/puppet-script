#!/bin/bash
echo "#####################################################"
echo "                   Starting cleanup "
echo "#####################################################"
#ps aux | grep -i wso2 | awk {'print $2'} | xargs kill -9
#rm -rf /mnt/*
sed -i '/environment/d' /etc/puppet/puppet.conf
echo "#####################################################"
echo "               Setting up environment "
echo "#####################################################"
rm -f /etc/facter/facts.d/deployment_pattern.txt
mkdir -p /etc/facter/facts.d

while read -r line; do declare  $line; done < dss_default.conf

echo product_name=$product_name >> /etc/facter/facts.d/deployment_pattern.txt  
echo product_version=$product_version >> /etc/facter/facts.d/deployment_pattern.txt  
echo product_profile=$product_profile >> /etc/facter/facts.d/deployment_pattern.txt  
echo vm_type=$vm_type >> /etc/facter/facts.d/deployment_pattern.txt
echo wso2_upgrade_jdk=$wso2_upgrade_jdk >> /etc/facter/facts.d/deployment_pattern.txt
echo wso2_patching_mode=$wso2_patching_mode >> /etc/facter/facts.d/deployment_pattern.txt


echo "#####################################################"  
echo "                    Installing "  
echo "#####################################################"  

puppet agent --enable  
puppet agent -vt  
puppet agent --disable

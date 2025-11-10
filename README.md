# sysinfo_gathering_routine_linux  
Automate basic system information gathering commands on Linux system  

  Save this as sysinfo.sh, make it executable with  
  chmod +x sysinfo.sh  
  , and run with   
  sudo ./sysinfo.sh   
  (you'll need sudo for some commands like lshw).

You might need to install sysstat package for iostat:   
sudo apt install sysstat  
Run with   
sudo ./sysinfo.sh > system_report.txt   
                                           to save output to a file

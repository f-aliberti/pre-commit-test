import sys
import os
import subprocess
subprocess.Popen(["mvn", "versions:set","-DgenerateBackupPoms=false","-DnewVersion="+sys.argv[1],], stdout=open(os.devnull, "w"), stderr=subprocess.STDOUT)

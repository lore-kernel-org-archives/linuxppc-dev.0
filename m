From: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: segfaults due to mmap (umoven: Input/Output error)
Date: Fri, 29 Oct 1999 17:28:13 +0200
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99102917335900.03412@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everybody

Several programs I compiled recently die with a segfault. 
strace shows: 
mmap (ptrace: umoven: Inout/Output Error...

There are lots of remarks about mmap-problems, but I didn't find a clear
solution. Is that a problem with glibc?
 I'm using kernel 2.2.9 with glibc-2.1.1-6c. Would a glibc-update fix the 
problem, or does somebody suggests something else?

Thanks

Wolfgang Haeuptli 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 27 May 2000 08:21:40 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: Lost in Shared Memory with Module
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <392FBDD5.7E672FBD@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My first try to use shared memory inside a module show many conflict
within header /sys/shm.h
So I changed the header for /linux/shm.h. But the shared memory function
has a sys_  prefix:
shmat is changed for sys_shmat. Unfortunatly there is a problem here:
the sys_shmat need a fourth parameter.
--->    asmlinkage int sys_shmat (int shmid, char *shmaddr, int shmflg,
unsigned long *addr);
and there is not man page about sys_shmat that explain the usage of the
addr parameter.

Is it the right way to share memory between module and application ?
Where can I found example of it ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

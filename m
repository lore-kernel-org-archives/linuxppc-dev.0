Date: Wed, 9 Jun 2004 19:17:35 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: trying to debug my failure to start "init"
Message-ID: <Pine.LNX.4.58.0406091911340.3310@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  just before i pack it in for the day, i'm still grappling with why i
can't get the linuxppc-2.5 kernel to start the init/minit program on my
8xx board.  very curious, since it used to be able to, even if it hung
immediately afterwards.

  for more feedback, i added a printk() call to the run_init_process()
function in init/main.c to see what it thought it was doing.  the tail end
of my boot sequence was:

...
Kernel command line: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
... snip ...
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).             <-- good
Mounted devfs on /dev                            <-- also good
Freeing unused kernel memory: 52k init
Trying run_init_process with /sbin/minit         <-- hmm, that should work
Trying run_init_process with /sbin/init
Trying run_init_process with /etc/init
Trying run_init_process with /bin/init
Trying run_init_process with /bin/sh
Kernel panic: No init found.  Try passing init= option to kernel.


  at this point, i'm out of ideas, and in need of a beer.  thanks to
everyone who's provided advice so far.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

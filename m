Date: Sat, 14 Apr 2001 23:42:39 -0300
To: linuxppc-dev@lists.linuxppc.org
Subject: hfs broken in bk tree?
Message-ID: <20010414234239.D7020@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Mounting my HFS partition with 2.4.4-pre1 (from the bk tree) crashes the
machine.  I can modprobe hfs without trouble, but when I mount the fs
(read-write), the screen scrolls up (as if I was holding down the return
key), and the machine is locked.  This is repeatable.  I haven't had
problems with 2.4.3-pre2.  (kernels in between haven't booted on my machine
with bootx.)  BTW, this is with an SMP kernel.  I haven't tested with a UP
kernel yet.  Passing nosmp from bootx doesn't stop the kernel from booting
all the CPUs :(

 My computer is a Daystar Digital Genesis MP, which is based on the 9500
board.  It has four 150MHz PPC604 CPUs.  I've got 128MB of RAM, and SCSI
hard drives.

 Is hfs known to be broken, or is it just me?

--
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

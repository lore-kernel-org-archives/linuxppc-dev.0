Date: Fri, 19 Feb 1999 20:30:35 -0800 (PST)
From: Scott Trimmer <strimmer@rift.foo.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Compiling Kernel 2.2.1 on a G3
Message-ID: <Pine.LNX.3.96.990219201949.20971B-100000@rift.foo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have tried for weeks to get ANY kernel compiled, and I can get the
kernel to compile.  But when I copy it into my System Folder on the mac,
and boot every piece of text on the consoles is colored boxed with colored
circles in the center of them.  Why is this, and what can I do?  The
penguin in the upper right corner shows correctly, as well as the first
message saying that kernel 2.2.1 is booting.

System Specs: 
Original G3 266 MiniTower w/ a ATI Rage II/DVD+
Apple 720 Monitor
6MB video mem

Steps I took to compile:
make menuconfig  (set settings)
make dep
make clean
make zImage
make modules
make modules-install
ftp'd the vmlinux file to another machine, booted MacOS ftp'd it back to
my computer in binary mode.  Installed in system folder, and ran bootx.  

Typing blind and starting X works (funny vmode but it works).  What can I
do?  I want to get this working.
	-Scott
P.S. Thanks for all your help in advance.  




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

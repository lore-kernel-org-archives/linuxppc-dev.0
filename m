Message-Id: <199912040336.VAA22147@sun92.texmemsys.com>
Date: Fri, 3 Dec 1999 21:36:43 -0600 (CST)
From: Jonathan Brauer <brauer@texmemsys.com>
Reply-To: Jonathan Brauer <brauer@texmemsys.com>
Subject: Root FS
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I posted last week and I'd like to thank those of you that responded.  In short, 
I'm porting linux to a custom PPC board.  Well, we've got the platform specific 
code written, and are to the point of mounting the root fs.

We have a root image, but for some reason seem to be unable to determine what 
boot parameters to load into the kernel to get it to work.  In short I was 
wondering how to get the kernel to recognize a ramdisk at a specific location 
and to mount this as the root device.

Do I need to use initrd?
How do I specify through the command line to use the disk and the like.

I have tried various messages to kernel, but all result in a panic saying it can 
not mount root device 00:00

This is for 2.3.30 btw.

Also, a bug we found earlier today has use confused.  We are using cross 
compilers from ix86 to PPC and the latest binutils, but the linker was 
overlapping static and globals located in the .sbss regions.  We hacked the 
linker to eliminate this problem, but it still concered me that this would 
happen.

TIA

Jonathan Brauer
Texas Memory Systems


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

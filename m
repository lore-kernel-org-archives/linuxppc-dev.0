Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Phillip Lougher <phillip@lougher.demon.co.uk>
Message-Id: <200108202353.AAA00763@lougher.demon.co.uk>
Subject: init process does nothing after being execve'd
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 21 Aug 2001 00:53:59 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to get the MVitsa 2.4.2 kernel running on a IBM vesta (STB03xxx)
with a VxWorks bootrom.  After a lot of trial and error work I have rewritten
the Linux bootloader to get the machine to the state the Linux kernel expects,
and have got the kernel to run.

The kernel now boots with an initrd image, but hangs after the initial init
exevce in linux/fs/exec.c::do_execve (called by execve in do_linuxrc).

I'm using my own filesystem for initrd which gives lots of debug information
(read superblock, read inode, etc.) and do_execve successfully
reads the elf header, but after do_execve nothing seems to happen.
I've used sash and a handwritten ppc/c program as init to discount
library problems, and I currently believe something is up with mmap.

I have obviously forgotten to do something, or I'm not aware of things I
should have changed.  Is there anyone out there who knows what's going wrong?

Thanks a lot for any info...

Phillip

Zarlink Semi Conductor, currently at home, late, Chepstow, Wales.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

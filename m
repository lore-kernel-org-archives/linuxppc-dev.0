Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF72B1318@amwmail.adaptivemicro.com>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Questions about debugfs and the Ext2 file system 
Date: Fri, 31 May 2002 09:29:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working with a custom board with an MPC823 running Linux version 2.4.6.
We are using the ext2 file system. I am noticing some problems with finding
inodes when copying or adding files after Linux is booted. I need to get the
list of blocks used by a file and was using debugfs "stat" command to get
the information. This command works correctly when looking at files that
were present when Linux booted. If I copy a file and then attempt to look at
the new file with the "stat" command then the inode cannot be found. If I
reboot then the file is found correctly.

We are using a ramdisk for booting and we also have a hard drive mounted
with some files on it. The same problem occurs when using the ramdisk or the
hard drive.

It is probably my lack of understanding of how the file system works with
Linux. If anyone could give me some information about why this is happening
and the best way to work with it I would appreciate it.

Thank you.

Cindy Peters
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

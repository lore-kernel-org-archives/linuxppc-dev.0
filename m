Subject: Kernel panic: No init found.?? Try passing init= option to kernel
From: "Mike G." <gohas@actinium.org>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1060827870.1060.20.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Aug 2003 10:29:59 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,
Can someone give me a clue what's going on?  I been trying to figure out
what wrong with this kernel. Is it because of the squashfs system which
I am trying to use.  I know this is quite a common problem and I have
been search old news archive but to no avail. Please help

OUTPUT:-

Int flash0: Using Static image partition definition
Creating 5 MTD partitions on "Int0":
0x00000000-0x00080000 : "kernel"
0x00080000-0x00180000 : "ramdisk"
0x00180000-0x00300000 : "user1"
0x00300000-0x00380000 : "uboot"
0x00380000-0x00400000 : "user2"
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 36k init
Kernel panic: No init found.  Try passing init= option to kernel.


I have check, the init is located at this location in the Ramdisk.

/bin/init -> ../etc/rc

But I am not sure the file system is mounted correctly.  Or is it
something wrong with the MTD because I customize the Flash mapping
myself.

Thank you in advance!


--
Mike G. <gohas@actinium.org>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

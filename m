Subject: Kernel panic: No init found.
From: "Mike G." <gohas@actinium.org>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 26 Sep 2003 14:44:34 +0800
Message-Id: <1064558689.16329.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi there,

Can someone help me with this.. .been try to figure it out for quite
sometime... and still stuck at it.  I am using u-boot-0.4.0 and
linux-2.4.20-rc2 and runnig it for a board equip with MPC857. I don't
know what is wrong with this. I have check it ramdisk log file
everything seem to be there .. including the init. I have try to mount
the squashfs on the host PC and run the init and it works. Hmm.. I am
out of ideas on what to try next.. Help me please please....

here the output :-

Inte0: Swapping erase regions for broken CFI table.
number of CFI chips: 1
init_inte: bank1, name:Inte0, size:4194304bytes
Inte flash0: Using Static image partition definition
Creating 5 MTD partitions on "Inte0":
0x00000000-0x00080000 : "kernel"
0x00080000-0x00180000 : "ramdisk"
0x00180000-0x00300000 : "user1"
0x00300000-0x00380000 : "uboot"
0x00380000-0x00400000 : "user2"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 44k init
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 180 seconds..

Regards,
Mike

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

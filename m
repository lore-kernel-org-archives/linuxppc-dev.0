Message-ID: <38BF5D01.D48C679D@ict.ac.cn>
Date: Fri, 03 Mar 2000 14:34:41 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: shell problem on MPC8xx
References: <NCBBKJKKGDLPHKDPAFFMKEBMCDAA.jsw-embedded@mindspring.com> <38BE41BF.EAF1A0DD@ict.ac.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

I can see everything on console port now.
The last a few messages are:

 CPM UART driver version 0.02
 ttyS00 at 0x0280 is a SMC
 ttyS01 at 0x0100 is a SCC
 ttyS02 at 0x0200 is a SCC
 RAM disk driver initialized:  16 RAM disks of 4096K size
 eth0: CPM ENET Version 0.2, 00:00:00:00:00:00
 RAMDISK: Compressed image found at block 0
 VFS: Mounted root (ext2 filesystem).

After these message, /bin/sh is running. But I can't see
anything on console port. Is that shell's problem?
The ram disk I am using is from mbx, can I use that directly?

Thanks!

LiuTao

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

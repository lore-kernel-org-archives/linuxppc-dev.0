Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <007b01c1a560$3e368b50$1a11efcb@industrialDiv.hanasys.co.kr>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Ramdisk Question
Date: Fri, 25 Jan 2002 14:22:11 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am porting linux on a custom mpc755 board.
I used linuxppc_2_4 from montavista rsync,
and simple-ramdisk.tar.gz from denx ftp.
The kernel stops after the following messages.
...
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 554k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 76k init
...

It boots well until execve("/bin/sh",argv_init,envp_init); of init() of init/main.c
Is there anything that I shouldn't forget to boot from ramdisk?

Thank you in advance.
- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

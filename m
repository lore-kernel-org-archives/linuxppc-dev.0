Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <001901c320c6$e8440090$6706a8c0@SPLENDOR>
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: "linuxppc-embedded" <linuxppc-dev@lists.linuxppc.org>
References: <00512BA4F9D3D311912A009027E9B8F407E4F6@NT> <Law14-OE46TH4DAcBOv000199dc@hotmail.com>
Subject: Linux booting on FADS823 board
Date: Thu, 22 May 2003 18:01:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi groups,

I have a problem booting Linux with u-boot.
Here are my configurations

Processor -> MPC823
Board     -> FADS823
Available RAM -> 0x000 to 0x 800000

Linux kernel Linked at -> 0x40000
mkimage on kernel done with Load address -> 0x40000
mkimage on kernel done with Entry point -> 0x4000c
mkimage on RAMDISK done with Load Address -> 0x100000
mkimage on RAMDISK done with Entry point -> 0x100000

>From u-boot command prompt, I do the following

> tftpboot 40000 linux.img
> tftpboot 100000 ramdisk.img
> bootm 40000 100000

It says successful loading kernel , as well as RAMDISK. But after which,
I do not get any further Linux banneers. In fact, the Linux kernel 's
printfs aren't seen.

I set the env variable bootargs as /dev/ram.. But in any case, only
after the kernel boots up and the VFS is initialized, the Rootfs is
going to come into picture, right ??

Any clues....

Rupesh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

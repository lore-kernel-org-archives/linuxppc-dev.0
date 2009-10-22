Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 34A03B7BA9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2009 01:08:15 +1100 (EST)
Received: by yxe8 with SMTP id 8so7494262yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 07:08:14 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Oct 2009 22:08:13 +0800
Message-ID: <e997b7420910220708i63b85ca1n256f332ddc6819c1@mail.gmail.com>
Subject: How to mount rootfs though harddisk when booting?
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: chelly wilbur <wilbur512@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc85xx with sata harddisk,which has a rootfs on sda3.

I ' ve tried to use  freescale's kernel image , which is  togehther
with the mpc85xx board, to successfully mount the sda3 filesystem when
booting,


But when I used my own kernle, it failed:



I am using  kernel 2.6.21.7 to mount the harddisk as the rootfs.

However, it failed in booting and print:


VFS: Cannot open root device "sda3" or unknown-block(0,0)

My kernel's bootargs are as followed:


root=/dev/sda3 rw console=ttyS0,115200 console=tty0


I guess there were some incorrect configs when doing kernel
menuconfig,  I' ve set "ext2,ext3", and some "sata" ,"scsi" configs,

but that might be  not enough.


May anyone please give me some  suggestions?

THX in advance.

Return-Path: <hangtoo@163.com>
Received: from m5-84.163.com (m5-84.163.com [202.108.5.84])
	by ozlabs.org (Postfix) with SMTP id 788F3679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 20:02:03 +1000 (EST)
Date: Wed, 10 May 2006 17:40:31 +0800
From: "hangtoo" <hangtoo@163.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: Kernel panic - not syncing: No init found.
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <4461BA19.032DB3.12441>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I try to make a new uRamdisk for my bubinga board(linux-2.6.14,PPC405EP).
actully I just copy the most of the files in the board,and compiled busybox with ppc tools.
but when I use the new uRamdisk for a try,it just showed up this errors(as follow),then reboot,back and forth...
**************************************************
RAMDISK: incomplete write (-28 != 32768) 4194304

EXT2-fs warning: checktime reached, running e2fsck is recommended

VFS: Mounted root (ext2 filesystem).

Freeing unused kernel memory: 116k init

attempt to access beyond end of device  //this is where the error begins.

ram0: rw=0, want=10330, limit=8192

Buffer I/O error on device ram0, logical block 5164

attempt to access beyond end of device

ram0: rw=0, want=10330, limit=8192

Buffer I/O error on device ram0, logical block 5164

attempt to access beyond end of device

ram0: rw=0, want=10330, limit=8192

Buffer I/O error on device ram0, logical block 5164

attempt to access beyond end of device

ram0: rw=0, want=10330, limit=8192

Buffer I/O error on device ram0, logical block 5164

Kernel panic - not syncing: No init found.  Try passing init= option to kernel.
//according to this note,is there something I have to do with my kernel??
 <0>Rebooting in 1 seconds..
*************************************************

Any help is appreciated.

regards
tony

Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 60E0967B82
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 20:31:41 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000034832.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Jul 2005 12:31:18 +0200
From: "David Grab" <d.grab@hima.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 6 Jul 2005 12:30:10 +0200
Message-ID: <000d01c58215$b0766380$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <000c01c5820a$19fc5be0$f201a8c0@SN7606>
Subject: AW: AW: initrd rootfs ramdisk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

i solved my problem with u-boot and linux. Now i have my rootfs ramdisk
mounted and functioning. But one output is weird.

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 1024) 4194304
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 96k init
ifconfig: socket: Function not implemented
### Application running ...
BusyBox v0.60.5 (2004.11.10-15:02+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.
# ls
bin   dev   etc   ftp   home  lib   proc  sbin  tmp   usr   var
#

why incomplete write? RAMDISK: incomplete write (-28 != 1024) 4194304

Thx for help,

David

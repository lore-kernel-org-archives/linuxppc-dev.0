Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E56E3681F7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 17:07:04 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j88EwuMu072003
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Sep 2005 14:58:56 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 08 Sep 2005 15:06:52 +0800
Message-Id: <1126163212.23563.8.camel@banana>
Mime-Version: 1.0
Subject: Can't run 8M ramdisk at 2.4.20 linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

    I build a 8M ramdisk file, it  works fine at 2.4.25 linux but fail
in 2.4.20.Why?
I do follow command to make 8M ramdsik, all files in the ramdisk is from
pRamdisk (download from denx ftp site).

dd if=/dev/zero of=new_ramdisk bs=1024k count=8
/sbin/mke2fs -F -m0 new_ramdisk
/sbin/tune2fs -c 0 new_ramdisk

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1434k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 56k init
attempt to access beyond end of device
01:00: rw=0, want=1647259183, limit=16384
attempt to access beyond end of device
01:00: rw=0, want=1647259183, limit=16384
attempt to access beyond end of device
01:00: rw=0, want=1647259183, limit=16384
attempt to access beyond end of device
01:00: rw=0, want=1647259183, limit=16384
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 180 seconds..

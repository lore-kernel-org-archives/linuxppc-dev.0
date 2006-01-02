Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id BF173688F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 01:48:50 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so2212509nzd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 02 Jan 2006 06:48:48 -0800 (PST)
Message-ID: <000701c60fab$9fdca6a0$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 2 Jan 2006 22:48:31 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Subject: VFS: Cannot open root device "31:03" or unknown-block(31,3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
  I've suffered for many days and "google" almost every where.
I would like to boot from the flash with jffs2 (i.e. using jffs2 as my
root /) . But it alyaws shows:
VFS: Cannot open root device..... (whole message is as below)

  Anybody knows what may cause this ? Please help and
thank you.

/HappyPhot

==============(booting message)==================
.......
physmap flash device: 1000000 at 70000000
phys_mapped_flash: Found 2 x8 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
5 cmdlinepart partitions found on MTD device phys_mapped_flash
Creating 5 MTD partitions on "phys_mapped_flash":
0x00000000-0x00200000 : "k4"
mtd: Giving out device 0 to k4
0x00200000-0x00400000 : "k6"
mtd: Giving out device 1 to k6
0x00400000-0x00800000 : "rd"
mtd: Giving out device 2 to rd
0x00800000-0x00c00000 : "jffs2"
mtd: Giving out device 3 to jffs2
0x00c00000-0x02000000 : "others"
mtd: Giving out device 4 to others
VFS: Cannot open root device "31:03" or unknown-block(31,3)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,3)
 <0>Rebooting in 180 seconds..
========================================== 

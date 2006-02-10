Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 3725667B89
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:52:52 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1ANqptT026112
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 15:52:51 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1ANqpxW015047
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 15:52:51 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup
Date: Fri, 10 Feb 2006 15:53:33 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA207A@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <galak@kernel.crashing.org>, <dibacco@inwind.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Normally is it the uboot that uncompresses the kernel or the kernel
uncompress itself?=20

>>How would something compressed uncompress itself?  If u-boot is being
used=20
>>it will uncompress a compressed kernel and put the image at physical
0.

Small correction. Just like a self extracting binary, a kernel can have
a decompression code prepended to the start of kernel which can
decompress the=20
Kernel.  This is how redboot for xscale is structured or syslinux /lilo
for x86.=20

Although u-boot has simplified this step by doing the CRC checksum of
the
uiMage header as well as data and also decompress the kernel. Based on
load
address, entry point, the kernel can start executing. =20

Now, whether cache is enable or not, MMU is enabled/disabled depends on
the
Developer. In current u-boot, the MMU is not used. I-Cache is On and
D-cache
is off.

Best Regards,

Atul

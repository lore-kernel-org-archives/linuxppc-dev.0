Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3D30680A1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 12:02:10 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j7J9vOJc015112
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Aug 2005 09:57:25 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F?= =?UTF-8?Q?=E5=A8=81?= <rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 19 Aug 2005 10:01:58 +0800
Message-Id: <1124416918.6752.1.camel@banana>
Mime-Version: 1.0
Subject: How to build more than 16M ramdisk for u-boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:

    I found if i build ramdisk more than 16M, i'll got error at using
mke2fs command.

dd if=/dev/zero of=ramdisk bs=1024k count=20

/sbin/mke2fs -F m0 ramdisk
mke2fs 1.36 (05-Feb-2005)
mke2fs: bad blocks count - ramdisk


why ?

I used FC3 & eldk 3.1.1.


Best Regard,
Rober Hsu

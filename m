Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6F3BFB70A8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 11:03:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: cuImage and multi image?
Date: Tue, 21 Sep 2010 03:03:22 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com><4C91C77B.8080501@windriver.com>
	<AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Shawn Jin" <shawnxjin@gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Shawn Jin [mailto:shawnxjin@gmail.com]=20
> Sent: Tuesday, September 21, 2010 1:53 AM
> To: Chen, Tiejun
> Cc: ppcdev; uboot
> Subject: Re: cuImage and multi image?
>=20
> >> I have a cuImage kernel in order to support legacy u-boot and a=20
> >> ramdisk image. Kernel boots fine if these two images are=20
> separate and=20
> >> "bootm $kernel $ramdisk" is used. But I can not make it to=20
> work using=20
> >> a single multi image that contains the kernel and ramdisk=20
> images. Is=20
> >> it even technically possible to boot a multi-image with cuboot=20
> >> wrapper?
> >
> > Try the following steps:
> > ------
> > 1. cp <your ramdisk.gz> arch/powerpc/boot/ramdisk.image.gz
> > 2. make cuImage.initrd.<your target>
> >
> > You can get one Image, cuImage.initrd.<your target>,=20
> including kernel and ramdisk.
>=20
> A follow up question. With this method, the total image size
> (uncompressed) is limited to the 4MB (the link address of the=20
> boot wrapper)?

No.

Cheers
Tiejun

>=20
> Thanks,
> -Shawn.
>=20

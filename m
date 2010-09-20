Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 2A255B6EF2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 03:52:32 +1000 (EST)
Received: by eyg24 with SMTP id 24so2520750eyg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 10:52:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C91C77B.8080501@windriver.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
	<4C91C77B.8080501@windriver.com>
Date: Mon, 20 Sep 2010 10:52:30 -0700
Message-ID: <AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
Subject: Re: cuImage and multi image?
From: Shawn Jin <shawnxjin@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>, uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I have a cuImage kernel in order to support legacy u-boot and a
>> ramdisk image. Kernel boots fine if these two images are separate and
>> "bootm $kernel $ramdisk" is used. But I can not make it to work using
>> a single multi image that contains the kernel and ramdisk images. Is
>> it even technically possible to boot a multi-image with cuboot
>> wrapper?
>
> Try the following steps:
> ------
> 1. cp <your ramdisk.gz> arch/powerpc/boot/ramdisk.image.gz
> 2. make cuImage.initrd.<your target>
>
> You can get one Image, cuImage.initrd.<your target>, including kernel and ramdisk.

A follow up question. With this method, the total image size
(uncompressed) is limited to the 4MB (the link address of the boot
wrapper)?

Thanks,
-Shawn.

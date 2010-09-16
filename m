Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 78B86B70A3
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 17:49:04 +1000 (EST)
Received: by ewy2 with SMTP id 2so653538ewy.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 00:49:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C91C77B.8080501@windriver.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
	<4C91C77B.8080501@windriver.com>
Date: Thu, 16 Sep 2010 00:49:02 -0700
Message-ID: <AANLkTin9yErB4dUfBQg2kC+dnz_sH6scazHqp=vfCV5g@mail.gmail.com>
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

> Try the following steps:
> ------
> 1. cp <your ramdisk.gz> arch/powerpc/boot/ramdisk.image.gz
> 2. make cuImage.initrd.<your target>
>
> You can get one Image, cuImage.initrd.<your target>, including kernel and ramdisk.

Cool! Thanks a lot, Tiejun.

-Shawn.

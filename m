Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 3151CB70AA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 16:21:23 +1000 (EST)
Received: by ewy2 with SMTP id 2so634711ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 23:21:21 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 15 Sep 2010 23:21:21 -0700
Message-ID: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
Subject: cuImage and multi image?
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>, uboot <u-boot@lists.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a cuImage kernel in order to support legacy u-boot and a
ramdisk image. Kernel boots fine if these two images are separate and
"bootm $kernel $ramdisk" is used. But I can not make it to work using
a single multi image that contains the kernel and ramdisk images. Is
it even technically possible to boot a multi-image with cuboot
wrapper?

On the cuImage kernel I have load address set to 0x400000 and the
entry address set to 0x400554 due to the cuboot wrapper. But to make a
multi image, both the load and the entry addresses should be set to
zero. And u-boot (1.1.2) bootm takes the entry address of the multi
image (i.e. 0x0) as the kernel entry address. 0x0 is certainly not the
entry address for a cuImage kernel.

Is there a possible workaround other than using two separate images?

Thanks,
-Shawn.

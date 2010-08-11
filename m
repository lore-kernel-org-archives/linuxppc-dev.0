Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 9B80FB70D9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 17:16:35 +1000 (EST)
Received: by eyh6 with SMTP id 6so12714466eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 00:16:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=ZSBNUYgwv3CKA1PEZm7Vkk6SsubcFR8410qz+@mail.gmail.com>
References: <AANLkTi=ZSBNUYgwv3CKA1PEZm7Vkk6SsubcFR8410qz+@mail.gmail.com>
Date: Wed, 11 Aug 2010 00:16:32 -0700
Message-ID: <AANLkTimHuOxhUW-qH1z27omr98Q+HpcKYkd6of=b7Di=@mail.gmail.com>
Subject: Re: kernel 2.6.33 fail to mount rootfs on ramdisk
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 10, 2010 at 11:55 PM, Shawn Jin <shawnxjin@gmail.com> wrote:
> Hi,
>
> The kernel 2.6.33 failed to mount the rootfs on the ramdisk. I enabled
> the ramdisk block device support and ext2 filesystem as shown below.
>
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_EXT2_FS=y
>
> Are these adequate configurations for kernel to support rootfs on
> ramdisk? What have I missed? The ramdisk image is from DENX's SELF.
> The boot message is shown below.

I figured that out. What I missed is CONFIG_BLK_DEV_INITRD.

Thanks,
-Shawn.

Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 8425167B62
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 00:48:02 +1000 (EST)
Message-ID: <44CA23A0.5030901@mdivac.com>
Date: Fri, 28 Jul 2006 10:48:00 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: Where to store the Linux kernel.
References: <BAY110-F35E07B168493E31407D7C2B2580@phx.gbl>
In-Reply-To: <BAY110-F35E07B168493E31407D7C2B2580@phx.gbl>
Content-Type: text/plain; charset=gb2312
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

Ming,

I have the XPS generated bootloader in bram. The bram is located at the
reset vector. The XPS bootloader loads U-Boot s-records from linear
flash into ram and then executes it. U-Boot can then handle booting the
Linux Kernel image (uImage, not zImage.elf) from linear flash.

XPS can program the linear flash for you. In XPS 8.1 the menu option is
"Device Configuration | Program Flash Memory". I use this to program the
U-Boot s-records and the Kernel uImage to linear flash.

I have not tried to put both the download.bit and Kernel uImage into
platform flash, so I can't comment on that.

Frank

Ming Liu wrote:
> Dear Frank,
>
>> I am using an ML403 in a similar way. I have the download.bit file
>> stored in platform flash. U-Boot, the Linux Kernel and initrd are stored
>> in the linear flash.
> That's just what I want! Can you say something in detail on how to put
> the bootloader and the kernel image in the linear flash in XPS? I know
> that XPS can generate a bootloader automatically. So can we use that
> one instead of U-boot?
> By the way, can we put both the download.bit and the Linux image
> zImage.elf in the platform flash and boot the system from here? If
> yes, then in the real product, I need only one platform flash to store
> my design then.
> Thanks for your telling.
>
> Regards
> Ming
>
> _________________________________________________________________
> 享用世界上最大的电子邮件系统— MSN Hotmail。 http://www.hotmail.com
>

Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 76B0167C60
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 19:28:34 +1000 (EST)
To: "David Grab" <d.grab@hima.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Jul 2005 08:36:46 +0200."
	<000001c5812b$eb088c70$f201a8c0@SN7606>
Date: Tue, 05 Jul 2005 10:18:54 +0200
Sender: wd@denx.de
Message-Id: <20050705081854.8096B353A4A@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: initrd rootfs ramdisk 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000001c5812b$eb088c70$f201a8c0@SN7606> you wrote:
> 
> i solved my problem last problem and now i get console output. :) So next
> step is to setup the root file system. I want to use an image loaded into
> ramdisk, but seems i´m missing something. I´m using u-boot to load the
> ramdisk and linux kernel. Actually i don´t know how the kernel gets the
> location of the loaded ramdisk. I only added the support (see Kernel

It gets passed in registers r4 (start address) and r5 (end address).

> configuration) and the command line parameter root=/dev/ram rw. But the boot
> command arguments from u-boot seems not recognized from the linux kernel.

But the kernel prints the boot parameters just fine.

> Should the option CONFIG_BOOT_LOAD point on the address of the ramdisk? I

No.

> hope someone could help me to trigger out my problem.

Are you sure that you have ext2 filesystem support  enabled  in  your
kernel configuration?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I perceive a possibility of an immediate  chronological  sequence  of
events which includes a violence.
                        - Terry Pratchett, _The Dark Side of the Sun_

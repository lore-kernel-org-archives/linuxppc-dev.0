To: "nagraj c" <cn_raju@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux hangs after MMU:mapin 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Jan 2004 12:05:51 +0530."
             <Law15-F93QzWsfdg29l00008f3e@hotmail.com>
Date: Thu, 01 Jan 2004 18:27:16 +0100
Message-Id: <20040101172721.69595C12DD@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Nag,

in message <Law15-F93QzWsfdg29l00008f3e@hotmail.com> you wrote:
>
>       I am trying to port Linux on PPC405GP. I have downloaded
> linuxppc_2_4_devel using BitKeeper and compiled using powerpc-linux-
> tools. And I followed the following steps to compile kernel.
>       make walnut_config
>       make mrproper
>       make menuconfig
>       make dep
>       make uImage
>
>       After exucuting final step, vmlinux.UBoot has been created in
> /linuxppc_2_4_devel/arch/ppc/boot/images.
>       Boot Loader: I am using U-BOOT-0.4.0 as a boot loader.
>       Board: Custom Board with IBM walnut405 features.

Did you adapt the kernel sources (1) for use with U-Boot? [The struct
board_info  as  defined  in  "arch/ppc/platforms/walnut.h"   is   not
compatible to U-Boot] and (2) for use with your hardware [Your custom
board is probably not exactly identical to the Walnut.]

>         What could be the problem? Any suggestions are apreciated.

See http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

Best regards, and a Happy New Year!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We have found all life forms in the galaxy are  capable  of  superior
development.
	-- Kirk, "The Gamesters of Triskelion", stardate 3211.7

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AB54767B67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 06:07:33 +1000 (EST)
To: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board,
	linux ke rnel 2.4.20
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 14 Jun 2006 10:36:11 CDT."
	<162B449665D6D643AD9E1D50FC6F4B1403F16D5F@mdcexc05.na.ops.local>
Date: Wed, 14 Jun 2006 22:07:31 +0200
Sender: wd@denx.de
Message-Id: <20060614200731.51722353C2B@atlas.denx.de>
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

In message <162B449665D6D643AD9E1D50FC6F4B1403F16D5F@mdcexc05.na.ops.local> you wrote:
> I downloaded the kernel you recommended and now I am trying to build a UBoot
> image that I can load unto flash.
> I use the following commands: 
> $ make mrproper
> $ make menuconfig
>   (select arch/ppc/configs/icecube_5200_defconfig file, exit and save)
> $ make uImage

Try instead:

	$ make mrproper
	$ make icecube_5200_config
	$ make oldconfig
	$ make dep
	$ make uImage

> Is there another sequence of make commands that I need to follow to create a
> UBoot image?

Not really.

Note that above is for  the  old  Lite5200  board.  For  the  (newer)
Lite5200B boards you must use latest version of U-Boot and Linux (top
of  tree  from  our git repositories), and "make lite5200b_config" to
start.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The greatest warriors are the ones who fight for peace."
- Holly Near

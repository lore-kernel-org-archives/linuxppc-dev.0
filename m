Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D8DE867A00
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 09:31:07 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id AE47672D5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 00:31:05 +0200 (CEST)
Received: from mail.denx.de (p54966024.dip.t-dialin.net [84.150.96.36])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 999DEB90C6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 00:31:05 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 378586D00B8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 00:31:04 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 2E44D3535F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 00:31:05 +0200 (MEST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel for MPC Lite 5200 will not compile 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Mar 2006 02:07:03 +0200."
	<20060328000703.GA95672@server.idefix.loc>
Date: Wed, 29 Mar 2006 00:31:05 +0200
Sender: wd@denx.de
Message-Id: <20060328223105.2E44D3535F7@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060328000703.GA95672@server.idefix.loc> you wrote:
> 
> I installed today ELDK 4.0 for the LITE5200 board (icecube).

There is no "ELDK 4.0 for the LITE5200 board".

> ./install -d /usr/local/eldk ppc_6xx

This installas ELDK 4.0 for PPC 6xx  processors.  Nothing  less,  but
nothing more either.

> After compiling u-boot and playing a little bit with it, i tried to
> compile the kernel 2.6.

Which kernel tree are you using? There is no support for  MPC5200  in
the  DENX  Linux  tree.  Well, some code is there, as there is in the
public 2.6 kernel tree, but it's known to be broken and not supported
by us.

> For this I used the git repository.

Which one?

> I copied the file arch/ppc/configs/lite5200_defconfig to .config, and
> tried the following one:
> make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage

That's not the official way to build images.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We, the unwilling, led by the unknowing, are doing the impossible for
the ungrateful. We have done so much, for so long, with so little, we
are now qualified to do anything with nothing.

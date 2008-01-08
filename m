Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CC5CDDF5A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 07:41:36 +1100 (EST)
Subject: Re: [PATCH] Miscellaneous for Taco
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200801082023.11475.sr@denx.de>
References: <477F13C0.7040006@pikatech.com>
	<1199566583.7291.63.camel@pasglop> <4783C3E8.3090107@pikatech.com>
	<200801082023.11475.sr@denx.de>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 07:41:13 +1100
Message-Id: <1199824873.6734.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-01-08 at 20:23 +0100, Stefan Roese wrote:
> On Tuesday 08 January 2008, Sean MacLennan wrote:
> > How about just 44x?
> >
> > Cheers,
> >     Sean
> >
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 7580aa5..682deae 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
> >         # PPC:
> >         default y if STB03xxx
> >         default y if PPC_MPC52xx
> > +       default y if 44x
> 
> No. Not all 44x have OHCI built in. Currently 440EP, 440EPx and 405EZ have it. 
> But since your patch only touches 440EP, you should just enable OHCI for 
> exactly this platform.

Note that the above Kconfig stuff just enabling the choice to enable
OHCI, it's not enabling build of OHCI per-se.

Ben.

Return-Path: <SRS0=i/5s=R3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id D9CCADDE27
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 20:26:30 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH] Miscellaneous for Taco
Date: Sat, 5 Jan 2008 10:26:26 +0100
References: <477F13C0.7040006@pikatech.com> <1199517865.7291.50.camel@pasglop>
In-Reply-To: <1199517865.7291.50.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801051026.26870.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Benjamin Herrenschmidt wrote:
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 7580aa5..480580c 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
> >         # PPC:
> >         default y if STB03xxx
> >         default y if PPC_MPC52xx
> > +       default y if TACO
> >         # MIPS:
> >         default y if SOC_AU1X00
> >         # more:
>
> I think we should instead reference use the 440EP here,

I vote for adding 440EP here.

Best regards,
Stefan

Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 61B9867A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 16:46:26 +1100 (EST)
In-Reply-To: <20050322211839.6A3DCC1510@atlas.denx.de>
References: <20050322211839.6A3DCC1510@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ba2549a1f7b9f73004d8d6e52415aee4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 22 Mar 2005 23:46:22 -0600
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] CPM2 cleanups 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jason, why did you bother to implement these functions, they dont=20
provide any value for us?

It looks like startup() & shutdown() are only used in IRQ probing code=20=

or code in which enable/disable will be used instead.

- kumar

On Mar 22, 2005, at 3:18 PM, Wolfgang Denk wrote:

> In message <1111523269.2987.58.camel@ad.doubleclick.net> you wrote:
>  >
> ...
>  > +static unsigned int cpm2_startup_irq(unsigned int irq)
>  > +{=A0
> > +=A0=A0=A0=A0=A0=A0 cpm2_unmask_irq(irq);
> > +=A0=A0=A0=A0=A0=A0 return 0;
>  > +}
>  > +
>  > +static void cpm2_shutdown_irq(unsigned int irq)
>  > +{
>  > +=A0=A0=A0=A0=A0=A0 cpm2_mask_irq(irq);
> > +}
>
> Why is cpm2_startup_irq() not void like cpm2_shutdown_irq() ?
>
> Best regards,
>
> Wolfgang Denk
>
> --=20
> Software Engineering:=A0 Embedded and Realtime Systems,=A0 Embedded =
Linux
>  Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
>  Overflow on /dev/null, please empty the bit bucket.
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

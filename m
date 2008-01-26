Return-Path: <SRS0=67yA=SQ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id EF5A3DDE16
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 00:37:49 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
Date: Sat, 26 Jan 2008 14:37:33 +0100
References: <4797C1AD.3040307@tiscali.nl>
	<20080123191704.2d74073a@zod.rchland.ibm.com>
In-Reply-To: <20080123191704.2d74073a@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801261437.34338.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 January 2008, Josh Boyer wrote:
> On Wed, 23 Jan 2008 23:37:33 +0100
>
> Roel Kluin <12o3l@tiscali.nl> wrote:
> > logical/bitand typo
> >
> > Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> > ---
> > diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> > index ebf9e21..dcfb459 100644
> > --- a/arch/powerpc/boot/4xx.c
> > +++ b/arch/powerpc/boot/4xx.c
> > @@ -104,7 +104,7 @@ void ibm4xx_denali_fixup_memsize(void)
> >  	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
> >  	cs = 0;
> >  	while (val) {
> > -		if (val && 0x1)
> > +		if (val & 0x1)
> >  			cs++;
> >  		val = val >> 1;
> >  	}
>
> Hm, good catch.
>
> Stefan, have you had problems with this code at all?

I'm not using the bootwrapper on a 4xx with Denali core.

Best regards,
Stefan

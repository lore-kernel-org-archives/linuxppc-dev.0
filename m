Return-Path: <r66093@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00D27B70AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 18:03:52 +1000 (EST)
Received: from mail97-am1 (localhost [127.0.0.1])	by mail97-am1-R.bigfish.com
 (Postfix) with ESMTP id 4271CE0490	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 18 Apr 2012 08:03:47 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.241])	by
 mail97-am1.bigfish.com (Postfix) with ESMTP id 223731A0045	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 08:03:45 +0000 (UTC)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>, Tabi Timur-B04825
 <B04825@freescale.com>
Subject: RE: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds flash
Date: Wed, 18 Apr 2012 08:02:45 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C079DD8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1334654129-1044-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <CAOZdJXVBb-CHa=PPa5446aVdQ323aBdv-9UTXx1SbkY2ArT14Q@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C079D0B@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C079D0B@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

But, I observed the Call Trace, but the partition can be parsed correctly.
Maybe your patch can fix this Call Trace.

Best Regards
Jerry Huang


> -----Original Message-----
> From: linuxppc-dev-bounces+r66093=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+r66093=3Dfreescale.com@lists.ozlabs.org] On
> Behalf Of Huang Changming-R66093
> Sent: Wednesday, April 18, 2012 3:47 PM
> To: Tabi Timur-B04825
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: RE: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds
> flash
>=20
> Yes, I tested with the latest Linux kernel, with my patch, the NOR and
> NAND MTD can work well.
>=20
> Best Regards
> Jerry Huang
>=20
>=20
> > -----Original Message-----
> > From: Tabi Timur-B04825
> > Sent: Wednesday, April 18, 2012 2:10 AM
> > To: Huang Changming-R66093
> > Cc: linuxppc-dev@lists.ozlabs.org; Kumar Gala
> > Subject: Re: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for
> > p1022ds flash
> >
> > On Tue, Apr 17, 2012 at 4:15 AM,  <Chang-Ming.Huang@freescale.com>
> wrote:
> >
> > > diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c
> > > b/arch/powerpc/platforms/85xx/p1022_ds.c
> > > index e74b7cd..0db3a7e 100644
> > > --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> > > +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> > > @@ -463,6 +463,7 @@ static void __init p1022_ds_setup_arch(void)
> > > =A0static struct of_device_id __initdata p1022_ds_ids[] =3D {
> > > =A0 =A0 =A0 =A0/* So that the DMA channel nodes can be probed individ=
ually:
> > > */
> > > =A0 =A0 =A0 =A0{ .compatible =3D "fsl,eloplus-dma", },
> > > + =A0 =A0 =A0 { .compatible =3D "fsl,p1022-elbc", },
> > > =A0 =A0 =A0 =A0{},
> > > =A0};
> >
> >
> > Have you actually tested this with an upstream kernel?  p1022_ds_ids[]
> > is broken upstream, so adding a new line won't work.
> >
> > Take a look at http://patchwork.ozlabs.org/patch/128533/
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

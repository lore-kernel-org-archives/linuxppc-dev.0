Return-Path: <r66093@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC802B7300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 17:46:44 +1000 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds flash
Date: Wed, 18 Apr 2012 07:46:35 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C079D0B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1334654129-1044-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <CAOZdJXVBb-CHa=PPa5446aVdQ323aBdv-9UTXx1SbkY2ArT14Q@mail.gmail.com>
In-Reply-To: <CAOZdJXVBb-CHa=PPa5446aVdQ323aBdv-9UTXx1SbkY2ArT14Q@mail.gmail.com>
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

Yes, I tested with the latest Linux kernel, with my patch, the NOR and NAND=
 MTD can work well.

Best Regards
Jerry Huang


> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Wednesday, April 18, 2012 2:10 AM
> To: Huang Changming-R66093
> Cc: linuxppc-dev@lists.ozlabs.org; Kumar Gala
> Subject: Re: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds
> flash
>=20
> On Tue, Apr 17, 2012 at 4:15 AM,  <Chang-Ming.Huang@freescale.com> wrote:
>=20
> > diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c
> > b/arch/powerpc/platforms/85xx/p1022_ds.c
> > index e74b7cd..0db3a7e 100644
> > --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> > +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> > @@ -463,6 +463,7 @@ static void __init p1022_ds_setup_arch(void)
> > =A0static struct of_device_id __initdata p1022_ds_ids[] =3D {
> > =A0 =A0 =A0 =A0/* So that the DMA channel nodes can be probed individua=
lly: */
> > =A0 =A0 =A0 =A0{ .compatible =3D "fsl,eloplus-dma", },
> > + =A0 =A0 =A0 { .compatible =3D "fsl,p1022-elbc", },
> > =A0 =A0 =A0 =A0{},
> > =A0};
>=20
>=20
> Have you actually tested this with an upstream kernel?  p1022_ds_ids[] is
> broken upstream, so adding a new line won't work.
>=20
> Take a look at http://patchwork.ozlabs.org/patch/128533/

Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A1E1B7043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 04:10:07 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds flash
Date: Tue, 17 Apr 2012 18:09:35 +0000
Message-ID: <CAOZdJXVBb-CHa=PPa5446aVdQ323aBdv-9UTXx1SbkY2ArT14Q@mail.gmail.com>
References: <1334654129-1044-1-git-send-email-Chang-Ming.Huang@freescale.com>
In-Reply-To: <1334654129-1044-1-git-send-email-Chang-Ming.Huang@freescale.com>
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

On Tue, Apr 17, 2012 at 4:15 AM,  <Chang-Ming.Huang@freescale.com> wrote:

> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platfo=
rms/85xx/p1022_ds.c
> index e74b7cd..0db3a7e 100644
> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> @@ -463,6 +463,7 @@ static void __init p1022_ds_setup_arch(void)
> =A0static struct of_device_id __initdata p1022_ds_ids[] =3D {
> =A0 =A0 =A0 =A0/* So that the DMA channel nodes can be probed individuall=
y: */
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,eloplus-dma", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,p1022-elbc", },
> =A0 =A0 =A0 =A0{},
> =A0};


Have you actually tested this with an upstream kernel?  p1022_ds_ids[]
is broken upstream, so adding a new line won't work.

Take a look at http://patchwork.ozlabs.org/patch/128533/

--=20
Timur Tabi
Linux kernel developer at Freescale=

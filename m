Return-Path: <B37400@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 089AB2C029D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 20:27:47 +1100 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 3/4] TDM Device Tree entries for various Freescale
 Platforms
Date: Mon, 11 Mar 2013 09:27:39 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E06FA5353@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
 <1362655668-26721-3-git-send-email-Sandeep@freescale.com>
 <CAOZdJXW7=3G8STRzaF04dmFZKFjp3=_2uy9F2pTZ-pe7L8nd7A@mail.gmail.com>
In-Reply-To: <CAOZdJXW7=3G8STRzaF04dmFZKFjp3=_2uy9F2pTZ-pe7L8nd7A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Friday, March 08, 2013 10:17 PM
> To: Singh Sandeep-B37400
> Cc: linuxppc-dev@lists.ozlabs.org; Aggrwal Poonam-B10812
> Subject: Re: [PATCH 3/4] TDM Device Tree entries for various Freescale
> Platforms
>=20
> On Thu, Mar 7, 2013 at 5:27 AM, Sandeep Singh <Sandeep@freescale.com>
> wrote:
> > arch/powerpc/boot/dts/p1022ds_36b.dts       |    3 +++
>=20
> You forgot to update p1022ds_3b.dts.
p1022ds_32b.dts includes "fsl/p1022si-post.dtsi" which is getting updated.
>=20
> > - * Copyright 2011 Freescale Semiconductor Inc.
> > + * Copyright 2011-2012 Freescale Semiconductor Inc.
>=20
> Do not update the copyright year in patches.
Ok, will correct this.
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale

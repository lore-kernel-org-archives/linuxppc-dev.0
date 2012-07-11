Return-Path: <r66093@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F2CF2C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 20:07:31 +1000 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/2] powerpc/mpc85xx: p1022ds support the MTD for NOR
 and NAND flash
Date: Wed, 11 Jul 2012 10:07:19 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C0EF6A3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <13C02C19-F509-45F9-B8D7-6081E3748642@kernel.crashing.org>
In-Reply-To: <13C02C19-F509-45F9-B8D7-6081E3748642@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, I think it is still needed for p1022ds,
I will resent it according to Timur's change.

Best Regards
Jerry Huang


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, July 03, 2012 1:54 AM
> To: Huang Changming-R66093
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/2] powerpc/mpc85xx: p1022ds support the MTD for NOR
> and NAND flash
>=20
>=20
> On Apr 16, 2012, at 8:42 PM, <Chang-Ming.Huang@freescale.com> <Chang-
> Ming.Huang@freescale.com> wrote:
>=20
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > The compatilbe 'simple-bus' is removed from the latest DTS for NAND
> > and NOR flash partition, so we must add the new compatilbe support for
> > p1022ds, otherwise, the kernel can't parse the partition of NOR and
> NAND flash.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > ---
> > arch/powerpc/platforms/85xx/p1022_ds.c |    1 +
> > 1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> If this is still relevant, please resubmit against my powerpc.git 'next'
> branch.
>=20
> - k

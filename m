Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A45D82C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 06:45:44 +1000 (EST)
Date: Thu, 11 Apr 2013 15:45:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] enable the coreint for the mpc85xx 64bit boards
To: Kumar Gala <galak@kernel.crashing.org>
References: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
 <6DEE94C2-19EB-487D-99B5-58789C9230BF@kernel.crashing.org>
In-Reply-To: <6DEE94C2-19EB-487D-99B5-58789C9230BF@kernel.crashing.org>
 (from galak@kernel.crashing.org on Thu Apr 11 08:21:24 2013)
Message-ID: <1365713105.3640.12@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>, Kevin Hao <haokexin@gmail.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2013 08:21:24 AM, Kumar Gala wrote:
>=20
> On Apr 10, 2013, at 8:32 PM, Kevin Hao wrote:
>=20
> > Hi,
> >
> > With the rework of the lazy EE, it seems that 64bit kernel works =20
> pretty
> > well on mpc85xx 64bit boards with lazy EE enabled. So this patch =20
> series
> > tries to enable the coreint for these boards by default. This passed
> > the ltp test on a t4240qds board and is based on Kumar's next =20
> branch.
> >
> > ---
> > Kevin Hao (2):
> >  powerpc/irq: remove the unneeded flag PACA_IRQ_EE_EDGE
> >  powerpc/85xx: enable coreint for all the 64bit boards
> >
> > arch/powerpc/include/asm/hw_irq.h       | 1 -
> > arch/powerpc/kernel/exceptions-64e.S    | 1 -
> > arch/powerpc/kernel/irq.c               | 8 --------
> > arch/powerpc/platforms/85xx/p5020_ds.c  | 5 -----
> > arch/powerpc/platforms/85xx/p5040_ds.c  | 5 -----
> > arch/powerpc/platforms/85xx/t4240_qds.c | 5 -----
> > 6 files changed, 25 deletions(-)
>=20
> Scott,
>=20
> I'd appreciate your review and ack on this change.

ACK

-Scott=

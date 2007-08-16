Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57A32DDEBF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 02:40:28 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <46C46C9A.2000107@freescale.com>
References: <11872134502476-git-send-email-timur@freescale.com>
	<2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>
	<46C46AB7.6070903@freescale.com>
	<9CE3D32E-B9C6-43B8-B944-45CE1DCCE8A2@kernel.crashing.org>
	<46C46C9A.2000107@freescale.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 11:40:18 -0500
Message-Id: <1187282419.30809.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-16 at 10:26 -0500, Timur Tabi wrote:
> Kumar Gala wrote:
> 
> >>     setmaskedbits_be32(&uccp->gumr_l,
> >>         UCC_SLOW_GUMR_L_MODE_QMC | UCC_SLOW_GUMR_L_TDCR_1 |
> >>         UCC_SLOW_GUMR_L_RDCR_16,
> >>                 UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
> >>         UCC_SLOW_GUMR_L_RDCR_MASK);
> >>
> >>     setmaskedbits_be32(&uccp->gumr_h,
> >>         UCC_SLOW_GUMR_H_SUART | UCC_SLOW_GUMR_H_TRX |
> >>         UCC_SLOW_GUMR_H_TTX, UCC_SLOW_GUMR_H_RFW);
> > 
> > Can you also show what the UCC_SLOW* values look like.
> 
> The second example is actually a trick that lets me set some bits and clear 
> others in one shot, so for the gumr_h register, all of the above values are 
> single bits.  I guess that's not a good example.

Such tricks deserve at least a comment.

Ben.

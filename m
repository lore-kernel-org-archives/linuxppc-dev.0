Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 01FF167C33
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 06:44:20 +1000 (EST)
Subject: Re: [PATCH 9/10] Add Vitesse 8244 PHY for MPC8641 HPCN platform.
From: Jon Loeliger <jdl@freescale.com>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44888A37.3090401@garzik.org>
References: <1149720298.23938.207.camel@cashmere.sps.mot.com>
	<44887BD3.7000009@garzik.org>
	<1149797603.23938.251.camel@cashmere.sps.mot.com>
	<44888A37.3090401@garzik.org>
Content-Type: text/plain
Message-Id: <1149799209.23938.256.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 15:40:09 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-08 at 15:36, Jeff Garzik wrote:
> Is it dependent on other stuff in Paul's tree?

Yes, very much so.  Most of this patch set is an
entirely new PPC board port against his arch/powerpc
basis.  The new PHY is incidentally on that board,
but the patches for its introduction could be
introduced through the netdev tree if needed.
It would just need to be coordinated some.  I am,
of course, willing to work it either way as needed.

jdl

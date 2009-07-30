Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 09BC1B7B86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:14:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63CACDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:14:38 +1000 (EST)
Message-Id: <BF196D82-DE80-4273-A2EE-FEFCFFF34F55@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090624163028.GA18825@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: Fix ethernet link detection on MPC8569E-MDS
	boards
Date: Wed, 29 Jul 2009 23:14:30 -0500
References: <20090624163028.GA18825@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 24, 2009, at 11:30 AM, Anton Vorontsov wrote:

> Linux isn't able to detect link changes on ethernet ports that were
> used by U-Boot. This is because U-Boot wrongly clears interrupt
> polarity bit (INTPOL, 0x400) in the extended status register (EXT_SR,
> 0x1b) of Marvell PHYs.
>
> There is no easy way for PHY drivers to know IRQ line polarity (we
> could extract it from the device tree and pass it to phydevs, but
> that'll be quite a lot of work), so for now just reset the PHYs to
> their default states.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   13 +++++++++++++
> 1 files changed, 13 insertions(+), 0 deletions(-)

applied to merge

- k

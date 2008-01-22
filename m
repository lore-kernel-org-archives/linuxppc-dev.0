Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A20FDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:39:23 +1100 (EST)
Date: Tue, 22 Jan 2008 14:36:41 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH v2 2/2] MPC8641 HPCN: call of_platform_bus_probe()
In-Reply-To: <1201033065.5716.175.camel@rhino>
Message-ID: <Pine.LNX.4.64.0801221436280.20645@blarg.am.freescale.net>
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
	<1201033065.5716.175.camel@rhino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 22 Jan 2008, Wade Farnsworth wrote:

> Call of_platform_bus_probe() on the MPC8641 HPCN, similar to what is
> done for other platforms.
>
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
>
> ---
> Updated per Kumar's comments.
>
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)

applied.

- k

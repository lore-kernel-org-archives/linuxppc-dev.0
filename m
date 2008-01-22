Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41CD8DE0E6
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:39:42 +1100 (EST)
Date: Tue, 22 Jan 2008 14:37:02 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH v2 1/2] Add localbus and flash nodes to mpc8641_hpcn.dts
In-Reply-To: <1201032819.5716.170.camel@rhino>
Message-ID: <Pine.LNX.4.64.0801221436490.20645@blarg.am.freescale.net>
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
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

> Add local bus, flash, and MTD partition nodes to mpc8641_hpcn.dts
>
> Also add compatible field for the soc node, so that it will be picked up
> by of_platform_bus_probe().
>
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
>
> ---
> Updated per Kumar's comments.
>
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   42 +++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>

applied.

- k

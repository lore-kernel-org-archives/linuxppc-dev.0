Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80D3DDDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 08:33:08 +1000 (EST)
Date: Wed, 29 Aug 2007 17:33:07 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 1/5] 86xx: Remove unnecessary loops_per_jiffy
	initialization code.
In-Reply-To: <1185560676.8055.173.camel@ld0161-tx32>
Message-ID: <Pine.LNX.4.64.0708291732540.26956@blarg.am.freescale.net>
References: <1185560676.8055.173.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 27 Jul 2007, Jon Loeliger wrote:

> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>
> Note -- This is a rebased version of an earlier patch
>           from July 17.  That one can be dropped.
>
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
>

applied.

- k

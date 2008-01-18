Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA726DE0C6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:54:30 +1100 (EST)
Date: Fri, 18 Jan 2008 00:52:01 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] mpc85xx_ads: add in missing of_node_put()
In-Reply-To: <20080102175001.GA18205@windriver.com>
Message-ID: <Pine.LNX.4.64.0801180051360.16433@blarg.am.freescale.net>
References: <20071221154009.GB20661@windriver.com>
	<20071223095038.ce1ad7a5.sfr@canb.auug.org.au>
	<20080102175001.GA18205@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Fri, 21 Dec 2007 10:12:38 -0500
> Subject: [PATCH] mpc85xx_ads: add in missing of_node_put()
>
> Add in missing of_node_put() after cpm2_pic_init(). This and other coding
> style cleanups as suggested by Stephen Rothwell.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

applied.

- k

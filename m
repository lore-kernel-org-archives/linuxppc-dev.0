Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFE70DDF3B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 03:09:59 +1000 (EST)
Date: Tue, 23 Oct 2007 12:10:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Subject: Re: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
Message-ID: <20071023171005.GA4638@loki.buserror.net>
References: <20071019.164143.75786621.davem@davemloft.net>
	<598D5675D34BE349929AF5EDE9B03E2701685446@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2701685446@az33exm24.fsl.freescale.net>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 06:47:32AM -0700, Medve Emilian-EMMEDVE1 wrote:
> Are you suggesting we leave those warnings there until somebody decides
> to fix all the portability issues of this driver? My patch is a small
> and insignificant improvement and not the revolution you're asking for,
> but is an small improvement today (I dislike warnings) vs. an improbable
> big one in the future.

It is not an improvement, as it moves the driver further away from being
64-bit clean.  A better fix would be to change the definition of
tx/rx_bd_ring_offset to unsigned long (or better yet, a union).

-Scott

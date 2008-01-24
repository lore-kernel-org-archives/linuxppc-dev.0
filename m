Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5C65DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 12:53:35 +1100 (EST)
Date: Wed, 23 Jan 2008 19:51:07 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] [POWERPC] 8xx: Use machine_*_initcall() hooks in
	platform code
In-Reply-To: <20080121185806.13486.56429.stgit@trillian.secretlab.ca>
Message-ID: <Pine.LNX.4.64.0801231950570.8658@blarg.am.freescale.net>
References: <20080121185806.13486.56429.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jan 2008, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/platforms/8xx/ep88xc.c          |    5 ++---
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    5 ++---
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 ++---
>  3 files changed, 6 insertions(+), 9 deletions(-)
>

applied.

- k

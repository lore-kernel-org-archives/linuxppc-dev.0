Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39181DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:19:06 +1100 (EST)
Date: Fri, 25 Jan 2008 02:16:35 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] 82xx and embedded6xx: Use machine_*_initcall()
	hooks in platform code
In-Reply-To: <20080125052324.8405.99760.stgit@trillian.secretlab.ca>
Message-ID: <Pine.LNX.4.64.0801250216220.9153@blarg.am.freescale.net>
References: <20080125052324.8405.99760.stgit@trillian.secretlab.ca>
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

On Thu, 24 Jan 2008, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5 +----
>  arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
>  arch/powerpc/platforms/embedded6xx/ls_uart.c |    5 +----
>  3 files changed, 3 insertions(+), 12 deletions(-)
>

applied.

- k

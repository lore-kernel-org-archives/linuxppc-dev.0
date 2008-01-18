Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34E9CDDF44
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 08:55:47 +1100 (EST)
Date: Fri, 18 Jan 2008 15:53:22 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fsl_soc: Fix get_immrbase() to use ranges, rather than
	reg.
In-Reply-To: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0801181553060.27596@blarg.am.freescale.net>
References: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
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

On Mon, 14 Jan 2008, Scott Wood wrote:

> The reg property in fsl soc nodes should be removed.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)

applied.  (dropped the size == 12 check).


- k

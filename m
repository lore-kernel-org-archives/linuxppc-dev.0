Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 859EBDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 03:22:27 +1100 (EST)
Date: Mon, 21 Jan 2008 10:19:54 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 05/10] powerpc: Add crash kernel support for 85xx
In-Reply-To: <20071122154619.GA26471@xyzzy.farnsworth.org>
Message-ID: <Pine.LNX.4.64.0801211018540.14428@blarg.am.freescale.net>
References: <20071122154619.GA26471@xyzzy.farnsworth.org>
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

On Thu, 22 Nov 2007, Dale Farnsworth wrote:

> Add the ability to build a ppc_85xx kernel to run at a physical
> address of 32MB.
>
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> ---
>  arch/powerpc/Kconfig                 |    2 +-
>  arch/powerpc/kernel/head_fsl_booke.S |   23 ++++++++++++++++++-----
>  arch/powerpc/mm/fsl_booke_mmu.c      |    6 +++---
>  3 files changed, 22 insertions(+), 9 deletions(-)
>

applied. (w/o Kconfig since this is useful for other purposes).

-k

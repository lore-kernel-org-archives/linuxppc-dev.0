Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BFD31A06DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:58 +1100 (AEDT)
In-Reply-To: <1444778451-16087-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: Delete old orphaned PrPMC 280/2800 DTS and boot file.
Message-Id: <20151015111058.39B611402B3@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-13-10 at 23:20:51 UTC, Paul Gortmaker wrote:
> In commit 3c8464a9b12bf83807b6e2c896d7e7b633e1cae7 ("powerpc:
> Delete old PrPMC 280/2800 support") we got rid of most of the C
> code, and the Makefile/Kconfig hooks, but it seems I left the
> platform's DTS file orphaned in the tree as well as the boot code.
> Here we get rid of them both.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5fab1d1cb18d27d1a2a5f110

cheers

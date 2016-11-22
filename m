Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60s3KGkzDvmm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:21 +1100 (AEDT)
In-Reply-To: <20161117162024.13344-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Fix old style declaration GCC warnings
Message-Id: <3tN60s1JBYz9t0p@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-17 at 16:20:24 UTC, Tobias Klauser wrote:
> Fix two [-Wold-style-declaration] GCC warnings by moving the inline
> keyword before the return type.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/60d862e531f310a32e272528ad4e04

cheers

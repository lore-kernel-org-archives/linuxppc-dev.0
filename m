Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 073381A06F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:59 +1100 (AEDT)
In-Reply-To: <20151008102828.00e869dc@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [FIX] powerpc: discard .exit.data at runtime
Message-Id: <20151015111058.DEFED140770@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-10 at 23:28:28 UTC, Stephen Rothwell wrote:
> .exit.text is discarded at run time and there are some references from
> that to .exit.data, so we need to discard .exit.data at run time as well.
> 
> Fixes these errors:
> 
> `.exit.data' referenced in section `.exit.text' of drivers/built-in.o: defined in discarded section `.exit.data' of drivers/built-in.o
> `.exit.data' referenced in section `.exit.text' of drivers/built-in.o: defined in discarded section `.exit.data' of drivers/built-in.o
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4c8123181d692c5b78650ee5

cheers

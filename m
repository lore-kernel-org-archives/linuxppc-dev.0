Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDnj2StCzF14h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 20:01:29 +1000 (AEST)
In-Reply-To: <20180517053715.24011-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/ptrace: Fix enforcement of DAWR contraints
Message-Id: <40qDnj11W5z9s3x@ozlabs.org>
Date: Mon, 21 May 2018 20:01:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-17 at 05:37:14 UTC, Michael Neuling wrote:
> Back when we first introduced the DAWR in this commit:
>   4ae7ebe952 powerpc: Change hardware breakpoint to allow longer ranges
> 
> We screwed up the constraint making it a 1024 byte boundary rather
> than a 512. This makes the check overly permissive. Fortunately GDB is
> the only real user and it always did they right thing, so we never
> noticed.
> 
> This fixes the constraint to 512 bytes.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> cc: <stable@vger.kernel.org> # v3.9+

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd6ef7eebf171bfcba7dc2df719c2a

cheers

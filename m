Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG85t1rzDr42
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:20:00 +1000 (AEST)
In-Reply-To: <878tixj3wg.fsf@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: fix invalid use of register expressions
Message-Id: <3xTPG75gK3z9t3w@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-08-05 at 17:55:11 UTC, Andreas Schwab wrote:
> binutils >= 2.26 now warns about misuse of register expressions in
> assembler operands that are actually literals, for example:
> 
> arch/powerpc/kernel/entry_64.S:535: Warning: invalid register expression
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a583c0a8d316d8ea52ea78491174a

cheers

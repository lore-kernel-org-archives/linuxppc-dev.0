Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHL4B2hzDqCf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:54 +1000 (AEST)
In-Reply-To: <20170316030440.32320-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Teach oops about radix vectors
Message-Id: <3wJCHL2Sc3z9rxm@ozlabs.org>
Date: Thu,  4 May 2017 08:18:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 03:04:40 UTC, Michael Neuling wrote:
> Currently if we oops caused by an 0x380 or 0x480 exception, we get a
> print which assumes SLB problems. With radix, these vectors have
> different meanings.
> 
> This patch updates the oops message to reflect these different
> meanings.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8915bcd68b2547c819b8a2a33c0981

cheers

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdP2S2BW3zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:37:36 +1000 (AEST)
In-Reply-To: <1503366697-17226-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org, npiggin@gmail.com
Subject: Re: powerpc/64s: Fix replay interrupt return label name
Message-Id: <3xdP2R5cXhz9t0j@ozlabs.org>
Date: Thu, 24 Aug 2017 22:37:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-22 at 01:51:37 UTC, Michael Ellerman wrote:
> In __replay_interrupt() we take the address of a local label so we can
> return to it later. However the assembler turns the local label into a
> symbol with a name like ".L1^B42" - where "^B" is literally "\002".
> This does not make for pleasant stack traces. Fix it by giving the
> label a sensible name.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/3e23a12bcaf18b3587088807722cd2

cheers

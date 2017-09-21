Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGZ6KkFzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:46 +1000 (AEST)
In-Reply-To: <20170919233219.26184-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/sstep: mullw should calculate a 64 bit signed result
Message-Id: <3xyKGY0040z9sRg@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-19 at 23:32:19 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> mullw should do a 32 bit signed multiply and create a 64 bit signed
> result. It currently truncates the result to 32 bits.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1575fe06f6b1d156ed31fb22c8631d

cheers

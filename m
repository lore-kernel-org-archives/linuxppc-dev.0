Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7bDH4WHZzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 22:46:39 +1000 (AEST)
In-Reply-To: <20170614234639.11997-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc: Fix emulation of mcrf in emulate_step()
Message-Id: <3x7bDH3Ytdz9s4q@ozlabs.org>
Date: Thu, 13 Jul 2017 22:46:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 23:46:38 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> The mcrf emulation code was looking at the CR fields in the reverse
> order. It also relied on reserved fields being zero which is somewhat
> fragile, so fix that too.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/87c4b83e0fe234a1f0eed131ab6fa2

cheers

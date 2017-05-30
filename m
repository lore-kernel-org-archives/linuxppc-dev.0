Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSX92BCvzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:21 +1000 (AEST)
In-Reply-To: <20170512035810.15070-1-andrew@aj.id.au>
To: Andrew Jeffery <andrew@aj.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, anton@samba.org
Subject: Re: powerpc: Tweak copy selection parameter in
 __copy_tofrom_user_power7()
Message-Id: <3wcSX91fQYz9s78@ozlabs.org>
Date: Tue, 30 May 2017 19:11:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-12 at 03:58:10 UTC, Andrew Jeffery wrote:
> Experiments with the netperf benchmark indicated that the size selecting
> VMX-based copies in __copy_tofrom_user_power7() was suboptimal on POWER8.
> Measurements showed that parity was in the neighbourhood of 3328 bytes,
> rather than greater than 4096. The change gives a 1.5-2.0% improvement in
> performance for 4096-byte buffers, reducing the relative time spent in
> __copy_tofrom_user_power7() from approximately 7% to approximately 5% in
> the TCP_RR benchmark.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a3f952df3c6d205fe3b1e0e4848d3c

cheers

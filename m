Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNH4QYGzDqnS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:51 +1100 (AEDT)
In-Reply-To: <20180123132250.4A2BD6EF69@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/mm/nohash: do not flush the entire mm when range is a
 single page
Message-Id: <3zVGNG3nlpz9sPk@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-23 at 13:22:50 UTC, Christophe Leroy wrote:
> Most of the time, flush_tlb_range() is called on single pages.
> At the time being, flush_tlb_range() inconditionnaly calls
> flush_tlb_mm() which flushes at least the entire PID pages and on
> older CPUs like 4xx or 8xx it flushes the entire TLB table.
> 
> This patch calls flush_tlb_page() instead of flush_tlb_mm() when
> the range is a single page.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5c8136fa1af7c0e9b4aec89cf2832f

cheers

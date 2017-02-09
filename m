Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCM5kGWzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:51 +1100 (AEDT)
In-Reply-To: <20161206014112.11201-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC] powerpc/64s: use start, size rather than start,
 end for exception handlers
Message-Id: <3vJzCM2n1xz9s7R@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-06 at 01:41:12 UTC, Nicholas Piggin wrote:
> start,size has the benefit of being easier to search for (start,end
> usually gives you the preceeding vector from the one you want, as first
> result).
> 
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1a6822d194c3f627eeb6aaca6688a5

cheers

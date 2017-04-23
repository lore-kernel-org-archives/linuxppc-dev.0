Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9nsx4gjnzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:53:09 +1000 (AEST)
In-Reply-To: <20170411174233.21902-8-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
Subject: Re: [7/9] powerpc/mm: Wire up ioremap_cache
Message-Id: <3w9nsx3nzqz9s2G@ozlabs.org>
Date: Sun, 23 Apr 2017 21:53:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 17:42:31 UTC, Oliver O'Halloran wrote:
> The default implementation of ioremap_cache() is aliased to ioremap().
> On powerpc ioremap() creates cache-inhibited mappings by default which
> is almost certainly not what you wanted.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f855b2f544d664cfa3055edb7ffd20

cheers

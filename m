Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [patch 1/6] mm: Allow architectures to define additional
	protection bits
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1215497929.8970.207.camel@pasglop>
References: <20080618223254.966080905@linux.vnet.ibm.com>
	<20080618223328.856102092@linux.vnet.ibm.com>
	<20080701015301.3dc8749b.akpm@linux-foundation.org>
	<1214920499.18690.10.camel@norville.austin.ibm.com>
	<1215409956.8970.82.camel@pasglop>
	<Pine.LNX.4.64.0807072143200.27181@blonde.site>
	<1215469468.8970.143.camel@pasglop> <1215497929.8970.207.camel@pasglop>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:35:51 -0500
Message-Id: <1215524151.20459.4.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@au1.ibm.com>,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-08 at 16:18 +1000, Benjamin Herrenschmidt wrote:

> Andrew, what tree should this go via ? I have further powerpc patches
> depending on this one... so on one hand I'd be happy to take it, but
> on the other hand, it's more likely to clash with other things...

Andrew has asked that it go through Paul, which now means you.

"It'd be simpler if Paul were to merge this.  It doesn't conflict with
any pending work."
http://ozlabs.org/pipermail/linuxppc-dev/2008-July/058948.html

> 
> Maybe I should check how it applies on top of linux-next.

Looks pretty clean:

patching file include/linux/mman.h
patching file mm/mmap.c
patching file mm/mprotect.c
Hunk #1 succeeded at 237 (offset -2 lines).

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

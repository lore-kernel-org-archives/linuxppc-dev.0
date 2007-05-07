Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 May 2007 15:47:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: Remove use of 4level-fixup.h for ppc32
Message-ID: <20070507054745.GC24464@localhost.localdomain>
References: <20070507053527.GB24464@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507053527.GB24464@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 03:35:27PM +1000, David Gibson wrote:
> For 32-bit systems, powerpc still relies on the 4level-fixup.h hack,
> to pretend that the generic pagetable handling stuff is 3-levels
> rather than 4.  This patch removes this, instead using the newer
> pgtable-nopmd.h to handle the elision of both the pud and pmd
> pagetable levels (ppc32 pagetables are actually 2 levels).
> 
> This removes a little extraneous code, and makes it more easily
> compared to the 64-bit pagetable code.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Urg.. forgot to mention.  This patch is dependent (textually, not
conceptually) on my earlier patch abolishing PTE_FMT.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

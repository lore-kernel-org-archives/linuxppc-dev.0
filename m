Return-Path: <dgibson@ozlabs.org>
Date: Thu, 11 Sep 2008 10:27:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: Get USE_STRICT_MM_TYPECHECKS working again
Message-ID: <20080911002712.GC4713@yookeroo.seuss>
References: <20080909050447.GC30127@yookeroo.seuss>
	<20080909120956.GA2576@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080909120956.GA2576@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 02:09:56PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 09, 2008 at 03:04:47PM +1000, David Gibson wrote:
> > The typesafe version of the powerpc pagetable handling (with
> > USE_STRICT_MM_TYPECHECKS defined) has bitrotted again.  This patch
> > makes a bunch of small fixes to get it building again.
> 
> It might be a better idea to mark these types __bitwise and use sparse
> to do the stricter checking..

Uh.. I don't think that would do quite the same thing.  In particular
it wouldn't catch assignments between (say) pmd_t and pte_t.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

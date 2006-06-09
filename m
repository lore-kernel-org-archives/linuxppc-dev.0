Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Jun 2006 11:49:50 +0300
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
	vma close
Message-ID: <20060609084950.GA30625@localhost.localdomain>
References: <1149257287.9693.6.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com>
	<1149281841.9693.39.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606021407580.6179@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0606021407580.6179@schroedinger.engr.sgi.com>
Cc: linux-mm@kvack.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, Jun 02, 2006 at 02:08:27PM -0700, Christoph Lameter wrote:
> On Fri, 2 Jun 2006, Adam Litke wrote:
> 
> > The real reason I want to "close" hugetlb regions (even on 64bit
> > platforms) is so a process can replace a previous hugetlb mapping with
> > normal pages when huge pages become scarce.  An example would be the
> > hugetlb morecore (malloc) feature in libhugetlbfs :)
> 
> Well that approach wont work on IA64 it seems.

Yes, but there's not much that can be done about that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Thu, 7 Dec 2006 10:47:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Virtex device tree generator proof of concept
Message-ID: <20061206234757.GD17446@localhost.localdomain>
References: <977C41F842E66D4CB2E41332313B615002F76196@XSJ-EXCHVS1.xlnx.xilinx.com>
	<528646bc0612061514mbcb2627wbe83cd47a06b31b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0612061514mbcb2627wbe83cd47a06b31b9@mail.gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hmm.. I seem to have missed the beginning of this thread, somehow.

On Wed, Dec 06, 2006 at 04:14:33PM -0700, Grant Likely wrote:
> On 12/6/06, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> >
> > Hi Grant,
> >
> > This looks really cool...  I've hacked around in it a bit to generate
> > device trees that go more completely through dtc.  (I'd be happy
> > to push these modifications back to you, if you're interested...)
> 
> Yes please, send me your patches.
> 
> >
> > I'm curious if you've heard of anyone using device trees other than
> > at boot time: for instance, using an incomplete device tree blob to
> > represent components discovered at runtime?  It looks like it should
> > be possible to rip out alot of the code from kernel/powerpc/prom.c in
> > recent kernels to parse incomplete device trees, too...  Any thoughts?

That reminds me:  I was definitely thinking about implementing a
"graft" function in libfdt for merging a tree from one blob into
another.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

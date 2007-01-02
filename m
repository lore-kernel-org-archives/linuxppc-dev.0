Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3BF0DDECA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 08:39:16 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1167773388.22068.443.camel@pmac.infradead.org>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166522096.25827.76.camel@pmac.infradead.org>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 08:37:43 +1100
Message-Id: <1167773863.6165.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	Paul Mackerras <paulus@samba.org>, bbrv@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-02 at 21:29 +0000, David Woodhouse wrote:
> On Wed, 2006-12-20 at 06:58 +1100, Benjamin Herrenschmidt wrote:
> > > OK, let's drop the patch and assume the device-tree will be fixed
> > > shortly. 
> > 
> > No, keep the patch for now. I'm afraid they aren't willing to fix their
> > device-tree.
> 
> They need to fix their firmware anyway, because it's screwed in other
> ways too -- they have an off-by-one error in their handling of partition
> numbers, so when yaboot tries to read a partition table it actually gets
> the first sector of the first partition, and it all goes downhill from
> there. That one was even _fixed_ in the Pegasos firmware last year, but
> it's come back in Efika -- and we _can't_ work around it in the kernel.
> 
> For Fedora, we're just going to wait for the fixed firmware; we can't
> sensibly support it as-is.

Ok. Well, Nicolas Det have unfortunately repeately said "we won't fix
the firmware" so it's bloody annoying but if you can apply that sort of
pressure on from a distro, that's good.

I've been very annoyed from the beginning with the refusal to discuss
the content of the device-tree publically before it was too late, the
firmware "in production" and "not fixable" (Nicolas words).

Ben.
 

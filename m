Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E0ABDDEE0
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 19:49:32 +1000 (EST)
Date: Sun, 6 May 2007 13:48:50 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Message-ID: <20070506134850.13689bf9@localhost.localdomain>
In-Reply-To: <20070506020427.GA22162@localhost.localdomain>
References: <20070506004737.31233.52611.stgit@localhost.localdomain>
	<67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
	<20070506020427.GA22162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 6 May 2007 12:04:27 +1000
David Gibson wrote:

> On Sun, May 06, 2007 at 03:04:14AM +0200, Segher Boessenkool wrote:
> > > +		pcmcia@0080 {
> > 
> > > +			#interrupt-cells = <1>;
> > 
> > > +			interrupt-parent = <ff000000>;
> > > +			interrupts = <d 1>;
> > > +		};
> > 
> > Since this node's children's interrupt representation
> > is different from the node's parent's, you need an
> > interrupt-map in here.  You also forgot "#address-cells"
> > and I think you need "ranges" too?
> 
> And we should use a reference, instead of an implicit phandle for the
> interrupt-parent.
> 
I  have one more patch for this - I think it makes sense to append it to the series...
Thinking it would be better to do the phandles->labels transition in one step for all the relevant
stuff in dts as well.  

-- 
Sincerely, Vitaly

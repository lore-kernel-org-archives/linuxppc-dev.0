Return-Path: <dgibson@ozlabs.org>
Date: Sun, 6 May 2007 12:04:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Message-ID: <20070506020427.GA22162@localhost.localdomain>
References: <20070506004737.31233.52611.stgit@localhost.localdomain>
	<67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 06, 2007 at 03:04:14AM +0200, Segher Boessenkool wrote:
> > +		pcmcia@0080 {
> 
> > +			#interrupt-cells = <1>;
> 
> > +			interrupt-parent = <ff000000>;
> > +			interrupts = <d 1>;
> > +		};
> 
> Since this node's children's interrupt representation
> is different from the node's parent's, you need an
> interrupt-map in here.  You also forgot "#address-cells"
> and I think you need "ranges" too?

And we should use a reference, instead of an implicit phandle for the
interrupt-parent.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

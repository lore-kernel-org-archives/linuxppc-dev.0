Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Feb 2007 15:57:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 12/14] Add device tree for Ebony
Message-ID: <20070221045756.GA23082@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
	<20070220021235.DC02DDDD06@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A58C89@az33exm25.fsl.freescale.net>
	<ee2e907ab59d7aa9b7bf026437419914@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee2e907ab59d7aa9b7bf026437419914@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 08:56:04PM +0100, Segher Boessenkool wrote:
> > Since UIC1 is cascaded off UIC0 in the interrupt tree,
> > UIC1 should have an interrupt-parent pointing to UIC0
> > so the interrupt tree can be traversed to the root.
> 
> Not necessary if UIC0 is the device tree parent of UIC1.
> (And in fact it would be "bad style").  But...
> 
> > I know this was beaten to death last week, but I would
> > still argue that in the device tree UIC0 and UIC1 should
> > be siblings.  (In the interrupt tree the cascade relationship
> > is described through interrupt-parent).
> 
> ... that is my opinion as well (as I'm sure you know ;-) ),
> and then of course you _do_ need the interrupt-parent property.

Ok, there are enough people of this opinion (including Paul), that
I've changed to representing the UICs as siblings.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

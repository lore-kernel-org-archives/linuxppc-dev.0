Return-Path: <dgibson@ozlabs.org>
Date: Mon, 10 Sep 2007 13:25:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Message-ID: <20070910032529.GA27828@localhost.localdomain>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 04:43:35PM +0200, Segher Boessenkool wrote:
> > +   l) Freescale DMA
> 
> > +    - compatible : Should be "fsl,dma".
> 
> Please choose some more specific name.  "fsl,mpc8540-dma" would
> be a reasonable choice perhaps.

More precisely, the compatible property should always have an specific
entry based on the exact chip the DMA engine resides in, as well as a
more general entry for any fsl dma engine of this type.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

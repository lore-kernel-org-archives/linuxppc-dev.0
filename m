Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 10:01:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: delete boot-cpu
	and chosen nodes from all DTSfiles)
Message-ID: <20070215230134.GB21654@localhost.localdomain>
References: <c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 02:26:41PM -0700, Yoder Stuart-B08248 wrote:
>  
> 
> > -----Original Message-----
> > From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org 
> > [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org] 
> > On Behalf Of Segher Boessenkool
> > Sent: Wednesday, February 14, 2007 7:40 PM
> > To: David Gibson
> > Cc: linuxppc-dev@ozlabs.org; Tabi Timur-B04825
> > Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen 
> > nodes from all DTSfiles
> > 
> > > My point is that the interrupt-controller property in 
> > /chosen *should*
> > > be there, but it doesn't make a lot of sense for it to be set by the
> > > bootloader (because it's a fixed property of the board).
> > 
> > And that means it shouldn't be in /chosen at all.  It's not
> > just a fixed property of the board, it is a physical property
> > of the board.  It doesn't belong in /chosen.
> 
> I agree with Segher here.  The interrupt-controller property doesn't
> belong in /chosen.

You're right.  Question is, can we change it now.  It's out there in
the documentation, on the other hand, I don't think the kernel
actually uses it anywhere yet.  BenH, opinion?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

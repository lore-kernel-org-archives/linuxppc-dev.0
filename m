Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 09:14:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Message-ID: <20070215221412.GB19126@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<2BDA6214-F867-4719-B0F6-E3409FB525F7@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB39@az33exm25.fsl.freescale.net>
	<DFBB231C-47A7-46B9-9D56-B651536B2C5A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DFBB231C-47A7-46B9-9D56-B651536B2C5A@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 12:41:50PM -0600, Kumar Gala wrote:
> 
> On Feb 15, 2007, at 11:49 AM, Yoder Stuart-B08248 wrote:
> 
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org
> >> [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org]
> >> On Behalf Of Kumar Gala
> > [snip]
> >>> New syntax d#, b#, o# and h# allow for an explicit prefix
> >>> on cell values to specify their base.  Eg: <d# 123>
> >>>
> >>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> >>>
> >>> ---
> >>
> >> What are people's thoughts on supporting '0x' and '0X' for hex?
> >
> > Are you saying allow d#1234, h#5678, and 0x5678?  Or use 0x instead
> > of h#?
> 
> I'm saying in addition to supporting the d#, h# notation.
> 
> The reason I'm suggesting support '0x' is its pretty natural from C  
> and I know there have been a number of times when I forget that all  
> int constants in .dts are hex.

I'd prefer not to do this.  I agree it would be nice in some ways, but
I'm worried that if people see 0x all over the place, they'll assume
that things without an 0x are decimal, which they can't be for
compatibility.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

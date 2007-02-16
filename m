Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 11:09:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Message-ID: <20070216000912.GD21654@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
	<20070215225739.GA21654@localhost.localdomain>
	<79929A88-229C-41D7-A8E8-3191743A3EFF@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <79929A88-229C-41D7-A8E8-3191743A3EFF@embeddedalley.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 03:37:36PM -0800, Dan Malek wrote:
> 
> On Feb 15, 2007, at 2:57 PM, David Gibson wrote:
> 
> > Yes, but hex-by-default is already implemented and out there.  We
> > can't change it without breaking compatibility horribly.
> 
> Compatibility with what?  The few dts files that exist
> that are still all changing frequently due to other
> tool modifications?  I'd prefer to change them now,
> rather than propagate this new syntax.

Nonetheless there are enough dts files out there - some of them within
vendors where I can't see them - that I absolutely do not want to
change something som fundamental in the format.

I have considered defining a "new-style" cell format, with delimiters
different from < > that uses C style literals.  But that idea's fairly
ugly too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 13:29:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807032959.GA13522@localhost.localdomain>
References: <20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
	<1186438523.938.83.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186438523.938.83.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 08:15:23AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-08-06 at 22:37 +0400, Sergei Shtylyov wrote:
> > 
> >     Actually, checking for the presence of all possible perverted
> > mapping 
> > props doesn't seem a good idea -- it's simpler to check for the
> > presence of 
> > one prop (like "direct-mapped" I was thinking about, or maybe
> > "simple-map").
> 
> Or more simply... if it's not a direct mapping, it doesn't have a ranges
> property and can't be walked down by conventional means.

But the ranges property is in the parent.  And if the flash bank is
only one of several devices in the same address space, it might be
messy to exclude the flash range from the parent's ranges property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

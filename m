Return-Path: <dgibson@ozlabs.org>
Date: Thu, 12 Apr 2007 16:51:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
Message-ID: <20070412065152.GA26210@localhost.localdomain>
References: <20070405020433.GA13891@dellserver.lan>
	<20070405161113.GA28063@ld0162-tx32.am.freescale.net>
	<46152D90.5070209@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46152D90.5070209@smiths-aerospace.com>
Cc: Linuxppc-dev@ozlabs.org, jdl@jdl.com, Jerry Van Baren <gvb.uboot@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 05, 2007 at 01:10:40PM -0400, Jerry Van Baren wrote:
> Scott Wood wrote:
> > On Wed, Apr 04, 2007 at 10:04:33PM -0400, Jerry Van Baren wrote:
> >> Implement the -R <number> option to add memory reserve slots.
> >> Add a -S <size> option makes the blob at least this number of bytes.
> > 
> > Wouldn't it be better to just specify the amount of extra space, instead
> > of the minimum total space?  That way, you only need to know what you
> > intend to add, not how much is already there.
> > 
> > -Scott
> 
> I thought briefly about this, but decided to implement a fixed size so 
> that someone could allocate, say, 8K of memory in their memory map 
> (likely flash) and know their blob would fit.
> 
> Maybe we need a little -s option to say "add -s bytes".

I think having both options would be a good idea.  It would also be
nice to have options to do this from the dts file (something similar
to /memreserve/).

> Jon suggested a --stats option to print out the important statistics. 
> That would also be a good enhancement.

Ok.  How would you envisage this working?

I've thought for some time that it would be a good idea to add an
"info" output mode.  In that mode instead of outputting a converted
device tree, it would give various bits of info on the input tree.
This would include things like the header field debugging information
that's currently output as pseudo-error messages when using dtb input.

I'm not sure to what extent your "--stats" idea would overlap with
that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

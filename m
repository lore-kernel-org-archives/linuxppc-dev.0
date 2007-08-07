Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 13:41:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807034136.GC13522@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<59e87834966d80bb143e1683fe751cd1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59e87834966d80bb143e1683fe751cd1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 09:59:24PM +0200, Segher Boessenkool wrote:
> >>> Yeah, better names please -- if possible, something that someone
> >>> without knowledge of this SoC will understand what it is.
> >>
> >> I think the names are probably ok - I'm assuming they're in keeping
> >> with the convention I've used of using the same names / abbreviations
> >> as in the CPU user manual.  I'm asking just for my own information,
> >> although a comment might not be a bad idea.
> 
> Fine with me -- I personally prefer "system-device-controller"
> and "clock-power-controller" or similar, but that is mostly a
> matter of taste.  As long as it's human readable it's fine.

Actually, it occurs to me that I've only sometimes been using that
convention for the names:  basically just for the weirdo chip control
devices that don't have a more widespread generic name.  I *have* been
strictly keeping to that convention for the labels in the dts (which
is why the PLB<->OPB bridge node is labelled POB rather than OPB, for
example).

> > -    Required properties:
> > +     - compatible : should contain the specific model of flash 
> > chip(s) used
> 
> "if known".

Added.

> > +       followed by either "cfi-flash" or "jedec-flash"
> 
> 
> > +    Flash partitions
> > +     - reg :
> > +     - read-only : (optional)
> 
> I'll hold off commenting on this until you've finish writing it,
> you probably know my opinion about it anyway :-)

Heh.. actually I was kind of hoping for your input on what's still
missing.  For example, I don't know what the necessary extra
properties for JEDEC chips are.

> One thing though -- what _exactly_ does "read-only" signify?

That's... a good question.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

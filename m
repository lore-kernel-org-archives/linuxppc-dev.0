Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <be8290e4a9e76608b8ede05deaaf91af@kernel.crashing.org>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<1182429733.24740.12.camel@localhost.localdomain>
	<558860c3d90100cd18df5f9a66cce3f9@kernel.crashing.org>
	<1182468325.24740.18.camel@localhost.localdomain>
	<be8290e4a9e76608b8ede05deaaf91af@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 18:16:31 +1000
Message-Id: <1182500191.24740.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: list <linuxppc-dev@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-22 at 09:52 +0200, Segher Boessenkool wrote:
> >> The "#address-cells" property should be completely absent,
> >> even; for interrupt matching, that means "treat as 0, no
> >> unit address used in interrupt mapping, just the interrupt
> >> number", and for the "normal" purpose (defining the format
> >> of devices on the bus rooted at / represented by this node)
> >> it means "there is no such bus" -- this is different from
> >> #address-cells = 0.
> >
> > I'd rather have it present and explicitely set to 0,
> 
> It is not the "right thing" to do, but should be harmless
> in most situations.

It's pretty much the right thing to do in that case imho... based on the
assumption that a common practice is worth 10 standards :-)

(I think I could even quote Linus on that one, let's just say that I
totally agree with him on those matters, I'd rather have people
"standardize" around existing common practices that happen to also work
well with existing code rather than doing differently because that's
what a 10 yrs old unmaintained piece of pdf says should be done :-)

Ben.

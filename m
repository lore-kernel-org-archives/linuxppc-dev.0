Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Feb 2007 10:29:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: macros and dtc
Message-ID: <20070219232907.GA17818@localhost.localdomain>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
	<1171915484.18571.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171915484.18571.55.camel@localhost.localdomain>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 07:04:44AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I could envision using something like cpp with #include
> > to get some standard SOC block properties, but macros
> > that try to account for board variations could be quite
> > complex.
> 
> For things like SoC, what I'd like is a way via #include or macros,
> whatever, to layout in a part of the tree a standard block, and then, be
> able to "overlay" on top of it.

Yes, certainly macros on their own wouldn't be very useful for SoCs or
standard boards.  But macros plus overlays should be quite useful.

> I can see other uses for macros for things like making easier to build
> interrupt-map properties for example, especially since most embedded
> boards use standard swizzling

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

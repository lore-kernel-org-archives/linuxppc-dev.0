Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <45b623f395654fc4f4920b9553794def@kernel.crashing.org>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 07:30:20 +0100
Message-Id: <1172298620.1902.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <b08248@freescale.com>,
	paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Sure, for every specific case one can envision a more neat
> and compact device tree ;-P

Still... I do think that even in the general case, providing a way to
directly encode pairs <parent,specifier> is useful, especially when
interrupt are wired in all sort of crazy ways as is common in the
embedded world.
 
> If in a certain tree you have this "problem" with not only
> the MAL but with lots of devices, you could introduce a
> "fake" interrupt nexus that doesn't represent a physical
> device as such, but that represents the combined cascaded
> interrupt controllers, and maps the interrupts to the nodes
> for the "physical" interrupt controllers.  Just don't make
> the mistake of putting an "interrupt-controller" property
> in there and all is just fine.  As an added bonus you end up
> with one single namespace for the interrupts (one interrupt
> domain in interrupt-mapping speak), which is probably what
> the chip documentation does as well.
> 
> 
> Segher
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

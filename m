Date: Fri, 20 Aug 2004 01:04:18 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Carl Aage Amundsen <carl@vmetro.no>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405GPr PCI target/host
Message-ID: <20040820080417.GA22083@gate.ebshome.net>
References: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION> <1092947874.10314.146.camel@localhost> <4125AA2C.6070306@vmetro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4125AA2C.6070306@vmetro.no>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 20, 2004 at 09:37:16AM +0200, Carl Aage Amundsen wrote:
> You both mentioned using a custom point-to-point driver that enables
> CPUs on the same PCI bus system to communicate together using TCP/IP. Is
> such a driver publicly available ?

Well, I doubt it would be of interest to anybody except our customers,
who actually have the hardware it was written for.

FWIW, MontaVista has something similar in their product, IIRC it's
called hhnet and even that driver is for a specific PCI bridge and DMA
engine.

> > I have worked with similar drivers in VxWorks (SMnet and Busnet) where
> they are a _must_, but now we are in the process of bringing up Linux on
> our embedded products. I think such a driver should be part of the
> standard Linux kernel in order to support a definite need in the
> embedded community.

Driver I wrote is highly specific to our custom hardware. This is
really nothing special about it. If you ever wrote or saw a driver for
modern ethernet controllers (e.g. all that stuff with buffer
descriptors) you can easily write this one. It's actually system
specific stuff which is not obvious (PCI bridge setup, IRQ wiring,
DMA etc) and unfortunately this stuff cannot be easily shared. I
suspect that any attempt to make it generic enough will result in
bloated monster nobody will want to use :).

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

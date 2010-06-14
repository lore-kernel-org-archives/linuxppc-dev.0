Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0E051007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 06:15:41 +1000 (EST)
Date: Mon, 14 Jun 2010 21:00:00 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Request review of device tree documentation
Message-ID: <20100614200000.GB7248@trinity.fluff.org>
References: <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<1276408773.1962.574.camel@pasglop>
	<4C147EA5.3060500@firmworks.com>
	<1276417792.1962.731.camel@pasglop>
	<AANLkTimc12G-YYTd4yQiviY-ijvJ9TzVEmxxaoF43xVR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimc12G-YYTd4yQiviY-ijvJ9TzVEmxxaoF43xVR@mail.gmail.com>
Cc: Mitch Bradley <wmb@firmworks.com>, Nicolas Pitre <nico@fluxnic.net>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	Olof Johansson <olof@lixom.net>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 13, 2010 at 11:36:57PM -0600, Grant Likely wrote:
> On Sun, Jun 13, 2010 at 2:29 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Sat, 2010-06-12 at 20:45 -1000, Mitch Bradley wrote:
> >
> >> Either fought or embraced.  To the extent that it is possible to focus
> >> solely on Linux and ARM, one could image doing a good HAL.
> >
> > That will come with a huge amount of comunity resistance sadly, but I
> > can imagine distros liking it.
> >
> > In general, I much prefer having all the necessary native drivers in the
> > kernel, and the device-tree to provide the right representation, and
> > avoid trying to abstract "methods" via a HAL. It's the Linux philosophy
> > as much as possible (even when defeated by ACPI).
> >
> > But if we're going to be forced by vendors into HALs, we can also make
> > sure that whatever they come up with is half reasonable :-)
> 
> I think there is more to be concerned about regarding binary blobs
> than HALs.  Many of the new SoCs require closed binaries to use all
> the hardware right now (graphics cores in particular).
> 
> Board vendors seem to be taking the plunge and modifying the kernel
> rather than trying to create a HAL for driving board specific
> features.

In my view HALs are a bad idea, they constrain you to one calling method
and make it difficult to evolve support in the kernel. I belive it is
part of the reason that we've always tried to avoid a standardised
kernel driver interface.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

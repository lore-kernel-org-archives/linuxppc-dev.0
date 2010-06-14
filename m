Return-Path: <jamie@shareable.org>
Received: from mail2.shareable.org (mail2.shareable.org [80.68.89.115])
	by ozlabs.org (Postfix) with ESMTP id AA9CA1007EB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 02:33:35 +1000 (EST)
Date: Mon, 14 Jun 2010 17:33:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Request review of device tree documentation
Message-ID: <20100614163324.GG9550@shareable.org>
References: <1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
	<AANLkTilZuMKzFN1hD1k4Q067jSkryPuWA2bhW0Y3GJTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilZuMKzFN1hD1k4Q067jSkryPuWA2bhW0Y3GJTg@mail.gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> > Like initrd, some people will find they need to compile it in to the
> > kernel image to fit some bootloader they can't change, or daren't risk
> > changing in already rolled out devices that they want to update to a
> > DT-using kernel.
> 
> Yes, I fully expect that.  Fortunately the situation is better than it
> was with powerpc.  Since the machine id is being retained, a
> DT-enabled kernel can continue to support non-DT systems.  There will
> not be a flag day to cut everything over to a new boot interface.

That's excellent, thank you.  I was a bit unsure about how that was going.

-- Jamie

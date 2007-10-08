Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F09DDDF3E
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 18:09:17 +1000 (EST)
Date: Mon, 8 Oct 2007 12:08:48 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
Message-ID: <20071008120848.3dde6199@kernel.crashing.org>
In-Reply-To: <EB9BE8E7-6437-403F-A7F4-953B393FDF51@kernel.crashing.org>
References: <20071005174015.GA11016@localhost.localdomain>
	<20071005174642.GB32145@localhost.localdomain>
	<47067ADE.9060306@ru.mvista.com>
	<20071005180553.GA32405@localhost.localdomain>
	<EB9BE8E7-6437-403F-A7F4-953B393FDF51@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Kumar,

On Fri, 5 Oct 2007 15:58:00 -0500
Kumar Gala wrote:

>=20
> On Oct 5, 2007, at 1:05 PM, Anton Vorontsov wrote:
>=20
> > On Fri, Oct 05, 2007 at 09:56:46PM +0400, Sergei Shtylyov wrote:
> >> Hello.
> >>
> >> Anton Vorontsov wrote:
> >>
> >>> Commit 5bece127f0666996ca90772229e00332a34e516c tried to fix
> >>> PCI/PCIe nodes, but actually it broke them even harder. ;-)
> >>
> >>    Of course. But shouldn't those be the subnoses of the "soc" =20
> >> type node?
> >
> > Nope. PCI's ranges =3D <>; isn't in the SOC address space.
> >
> > Valentine Barshak posted a patch titled "[RFC] [PATCH] PowerPC: Add =20
> > 64-bit
> > phys addr support to 32-bit pci" that started using =20
> > of_translate_address()
> > for ranges, and of_translate_address() will not work if PCI placed =20
> > in the
> > SOC node. Not sure if that patch applied or not, though.
>=20
> I'm confused, what's the actual issue with PCI that this patch =20
> addresses?
>=20
=46rom what I can see, move of the PCI node out of the SoC node, inspired by =
the recent flame talk about it :)
I guess pretty soon, we'll have "proper" ranges parsing for pci, that does =
of_translate_address() and requires
either tuned-up parent ranges, or residing outside of the SoC node, this is=
 the reason...

> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


--=20
Sincerely, Vitaly

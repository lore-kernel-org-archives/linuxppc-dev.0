Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id B8A2ADDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:26:53 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROM mappings in
	=?iso-8859-1?q?the=09physmap=5Fof_MTD?= driver.
Date: Thu, 27 Mar 2008 10:26:51 +0100
References: <200803261344.03438.laurentp@cse-semaphore.com>
	<47EA6B11.7050804@ru.mvista.com>
	<777c028aa41fe870542afdb4fa7d2db6@kernel.crashing.org>
In-Reply-To: <777c028aa41fe870542afdb4fa7d2db6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803271026.51555.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 March 2008 16:34, Segher Boessenkool wrote:
> >>>      {
> >>> +        .compatible    =3D "physmap-ram",
> >>> +        .data        =3D (void *)"map_ram",
> >>> +    },
> >>> +    {
> >>> +        .compatible    =3D "physmap-rom",
> >>> +        .data        =3D (void *)"map_rom",
> >>> +    },
> >
> >> Why the cast?  It's redundant afaics.
> >
> >   To be in line with the surrounding code...
>=20
> I see _that_, but it's not a great argument IMNSHO.  Could I trick
> you into preceding this patch with a cleanup patch for the existing
> casts?

Ok. I'll submit a new patch as soon as we agree on a compatible name.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

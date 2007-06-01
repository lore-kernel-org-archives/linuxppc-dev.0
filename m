Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADC39DDEE6
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 16:29:20 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l516TEVe013131
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 23:29:15 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l516TDd0001581
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 01:29:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Fri, 1 Jun 2007 14:29:10 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C307809@zch01exm26.fsl.freescale.net>
In-Reply-To: <A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
	<A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,=20

>=20
> On May 31, 2007, at 9:01 PM, Zhang Wei-r63237 wrote:
>=20
> > Hi, Kumar,
> >
> >>
> >> Can this be fixed by just setting hose->bus_offset in add_bridge?
> >>
> >> Doing this in exclude is very bad.
> >
> > That's my original doing. If there a PCI bridge card be=20
> pluged into =20
> > PCI
> > slot of hose0, I can not ensue the bus_offset number of hose1.
>=20
> Ok, but can't we use hose0's last_busno and use that set hose1-=20
>  >first_busno & hose1->bus_offset?

When in add_bridge(), the pci bus scan is not start, so we do not know
hose0's last_busno.

Thanks!
Wei.

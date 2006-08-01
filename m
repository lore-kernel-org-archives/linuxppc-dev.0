Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5D52F67B60
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 13:20:27 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k713KQW6010177 for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 20:20:26 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k713KNbf008194
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 22:20:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: RE: RE: cpm_dpalloc
Date: Tue, 1 Aug 2006 11:20:48 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D071265@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060731133919.31980@gmx.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Keinen Namen" <GSM909@gmx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm not very familiar with SPI.  See if someone on the list can help.

Best Regards,
Leo
> -----Original Message-----
> From: Keinen Namen [mailto:GSM909@gmx.de]
> Sent: Monday, July 31, 2006 9:39 PM
> To: Li Yang-r58472
> Subject: Re: RE: RE: cpm_dpalloc
>=20
> Thx, now it=B4s working fine.
>=20
> But my Problem didn=B4t solved :(
> But I have an other Question about SPI.
>=20
> How can I see that the init of RX and TX Parameter are succsesful ?
> I just looking till the CPM_CR_FLG till is cleard but I did not see if =
the init
> is ok?
>=20
> I try to look at the RX internal byte count in the Parameter ram, but =
there is nothing
> chance.
>=20
> Regards
> Fred
>=20
> -------- Original-Nachricht --------
> Datum: Mon, 31 Jul 2006 17:24:30 +0800
> Von: "Li Yang-r58472" <LeoLi@freescale.com>
> An: "Keinen Namen" <GSM909@gmx.de>
> Betreff: RE: RE: cpm_dpalloc
>=20
> > Yes, but that patch is for powerpc arch.  You can use this patch for =
ppc.
> > http://patchwork.ozlabs.org/linuxppc/patch?id=3D4317
> >
> > Best Regards,
> > Leo
> > > -----Original Message-----
> > > From: Keinen Namen [mailto:GSM909@gmx.de]
> > > Sent: Monday, July 31, 2006 5:21 PM
> > > To: Li Yang-r58472
> > > Subject: Re: RE: cpm_dpalloc
> > >
> > > Thanks for your fast Help.
> > >
> > > I=B4m not firm in patches. Is this the patch ?
> > > http://lkml.org/lkml/2006/6/30/108
> > >
> > > Regards
> > > Fred
> > > -------- Original-Nachricht --------
> > > Datum: Mon, 31 Jul 2006 16:56:54 +0800
> > > Von: "Li Yang-r58472" <LeoLi@freescale.com>
> > > An: GSM909@gmx.de, linuxppc-embedded@ozlabs.org
> > > Betreff: RE: cpm_dpalloc
> > >
> > > > There is a bug in rheap for alignment.  The patch is still =
hanging
> > around.
> > > >
> > > > Search rheap and alignment on the linuxppc-dev list for patch
> > previously
> > > > posted.
> > > >
> > > > Best Regards,
> > > > Leo
> > > > > -----Original Message-----
> > > > > From: =
linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> > > > > =
[mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
> > > > Behalf Of
> > > > > GSM909@gmx.de
> > > > > Sent: Monday, July 31, 2006 4:50 PM
> > > > > To: linuxppc-embedded@ozlabs.org
> > > > > Subject: cpm_dpalloc
> > > > >
> > > > > Hi All
> > > > >
> > > > > I have a MPC82xx Processor from Freescale with Linux 2.6.14 ( =
Can=B4t
> > > > chance to an
> > > > > new version).
> > > > >
> > > > > My Problem is that I want to allocate a 64byte of memory in =
the dual
> > > > ported ram
> > > > > with an alignment of 64bytes. (Needed for SPI Parameter Ram)
> > > > >
> > > > > the funktion cpm_dpalloc(64,64) returned 0x220 but that are =
not in a
> > 64
> > > > byte
> > > > > alignment.
> > > > >
> > > > > Regards
> > > > > Fred
> > > > > --
> > > > >
> > > > >
> > > > > Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu =
sparen!
> > > > > Ideal f=FCr Modem und ISDN: =
http://www.gmx.net/de/go/smartsurfer
> > > > > _______________________________________________
> > > > > Linuxppc-embedded mailing list
> > > > > Linuxppc-embedded@ozlabs.org
> > > > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > > > _______________________________________________
> > > > Linuxppc-embedded mailing list
> > > > Linuxppc-embedded@ozlabs.org
> > > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >
> > > --
> > >
> > >
> > > Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*. Nur noch kurze Zeit!
> > > "Feel free" mit GMX DSL: http://www.gmx.net/de/go/dsl
>=20
> --
>=20
>=20
> Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*. Nur noch kurze Zeit!
> "Feel free" mit GMX DSL: http://www.gmx.net/de/go/dsl

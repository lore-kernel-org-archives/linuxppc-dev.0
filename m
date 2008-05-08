Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10A00DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 12:08:33 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4828RfT015566
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 19:08:27 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m4828OSV012505
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 21:08:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add support for ULI RTC
Date: Thu, 8 May 2008 10:08:22 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C152D@zch01exm27.fsl.freescale.net>
In-Reply-To: <EFF7334F-3526-4E2B-8D5C-B97A02BDA71A@kernel.crashing.org>
References: <20080505185607.GB4906@polina.dev.rtsoft.ru>
	<EFF7334F-3526-4E2B-8D5C-B97A02BDA71A@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Anton Vorontsov" <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+jinzhengxiong=3Dgmail.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+jinzhengxiong=3Dgmail.com@ozlabs.or
> g] On Behalf Of Kumar Gala
> Sent: Tuesday, May 06, 2008 3:12 AM
> To: Anton Vorontsov
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add=20
> support for ULI RTC
>=20
>=20
> On May 5, 2008, at 1:56 PM, Anton Vorontsov wrote:
>=20
> > The ULI "Super South Bridge" contains ISA bridge to the legacy=20
> > devices, such as Super IO mouse/keyboard/floppy disk controllers,=20
> > parallel port, i8259 interrupt controller and so on.
> >
> > On the MPC8610HPCD, i8259 seems to be disabled (mpc8610_hpcd.c=20
> > confirms this), and other peripherals are not traced out.
> > So we use only RTC.
> >
> > This patch also adds ULI quirk to make RTC actually work=20
> (this quirk=20
> > differs a bit from the one in the fsl_uli1575.c).
>=20
> Can we just one quick for both?

mpc8610HPCD board did not use the quirks in fsl_uli1575.c=20

Jason

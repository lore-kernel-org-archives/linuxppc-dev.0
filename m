Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id BD44EDDE9E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:40:54 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 57D47F4911A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 20:40:53 +0200 (CEST)
Subject: Re: powerpc port for sbc8260-based board problem
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080507182209.GA2710@loki.buserror.net>
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>
	<20080507182209.GA2710@loki.buserror.net>
Date: Wed, 07 May 2008 20:40:52 +0200
Message-Id: <1210185652.3519.18.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Scott

Am Mittwoch, den 07.05.2008, 13:22 -0500 schrieb Scott Wood:
> On Wed, May 07, 2008 at 01:31:52AM -0700, Boris Shteinbock wrote:
> >      /* Monitor port/SMC1 */
> >      smc1: serial@11a80 {
> >        device_type =3D "serial";
> >        compatible =3D "fsl,mpc8260-smc-uart",
> >                     "fsl,cpm2-smc-uart";
> >        reg =3D <0x11a80 0x20 0x1100 0x40>;
>=20
> The second reg resource depends on where your firmware set up the SMC pra=
m
> regs.  With U-boot, it's usually zero.
>=20
> Note that as of 2.6.26-rc1, this is set up dynamically instead, and the
> second resource should be 0x87fc 2.
>=20
You are right with 0x87fc. It is one more point.
Also if your brg clock-frequency-property was correctly fixed from
u-boot.

My story is follow: we have mpc8247 based card.
The problem with smc happens due to the cpm reset.
Of course, if you have not CONFIG_PPC_EARLY_DEBUG_CPM with
CONFIG_PPC_CPM_NEW_BINDING.
May be it is some kind of mistake, but i could fix the problem with the
patch i told above.
Could give me some your note, please? Thank you.

Regards
Sergej.


--=20
Dipl.-Ing. Sergej Stepanov=20
Software-Entwicklung

IDS GmbH=20
E-PA  (Entwicklung - Prozess Automatisierung)
Nobelstr. 18,=20
D-76275 Ettlingen=20
T. (0) 72 43/2 18-615=20
F. (0) 72 43/2 18-100=20
E. Sergej.Stepanov@ids.de

<http://www.ids.de>
Gesch=C3=A4ftsf=C3=BChrer: Norbert Wagner, Friedrich Abri=C3=9F=20
Sitz der Gesellschaft: Ettlingen=20
Amtsgericht Mannheim HRB 362503=20

Return-Path: <Enzo.Figini@italtel.it>
Received: from ns.italtel.it (ns.italtel.it [138.132.53.3])
	by ozlabs.org (Postfix) with ESMTP id D0F0E6832C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 16:16:53 +1000 (EST)
Received: from ns.italtel.it (localhost [127.0.0.1])
	by ns.italtel.it (8.12.11/8.12.11) with ESMTP id j8L5r0eh011866
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 07:53:01 +0200 (MEST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 21 Sep 2005 07:52:57 +0200
Message-ID: <C6FBD65010EC044A8ACF666854D4D053BF9E25@BESTWO.corp.dom>
From: "Figini Enzo" <Enzo.Figini@italtel.it>
To: "Rune Torgersen" <runet@innovsys.com>,
	"Stevan Ignjatovic" <stevan@iritel.com>, <linuxppc-embedded@ozlabs.org>
Subject: R: MPC8250 MCC operating on 2-bit channels
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I use MCC1&2 on MPC8260/66/80 using 7 & 8 bit for channel without =
problem.
Take care that SIRAM setting is correct.
Remember to program also the bits not used (connect to nothing).

EF

> -----Messaggio originale-----
> Da: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org]Per conto di=20
> Rune Torgersen
> Inviato: marted=EC 20 settembre 2005 19.43
> A: Stevan Ignjatovic; linuxppc-embedded@ozlabs.org
> Oggetto: RE: MPC8250 MCC operating on 2-bit channels
>=20
>=20
> > -----Original Message-----
> > From: linuxppc-embedded-bounces@ozlabs.org Stevan Ignjatovic
> > Sent: Tuesday, September 20, 2005 10:17
> > Subject: MPC8250 MCC operating on 2-bit channels
>=20
> > Has anybody dealt with 2-bit channels on MCC? What can cause such
> > problems (remember that everything works fine with 8-bit=20
> channels). I
> > would also appreciate if somebody has the possibility to implement
> > similar test.
>=20
> I am using 7 bit channels without any problems (tx and rx) on=20
> MCC 1 and
> 2.
> (on an MPC8266)
> Can you send me a dump of your SIRAM settings, and I'll take a look at
> them?
>=20
> Be aware of one thing (at least for 826x with 2 MCC's), first=20
> channel on
> MCC2 is numbered 128, not 0
>=20
>=20
> Rune Torgersen
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

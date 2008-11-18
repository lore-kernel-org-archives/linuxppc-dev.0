Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 73C0BDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Nov 2008 02:35:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AMCC 460EX SATA drive on Canyonlands
Date: Tue, 18 Nov 2008 09:35:50 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F885@tanisys-ex2.Tanisys.Local>
In-Reply-To: <1226969645.808.13.camel@lt-linuxhenry>
References: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net><4921A2EE.6050201@freescale.com><DF6C7BC3780EE44B83430A9F756D43B60858239D@SJEXCH03.ds.jdsu.net><4921BA09.1030508@freescale.com>
	<1226969645.808.13.camel@lt-linuxhenry>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: "Henry Bausley" <hbausley@deltatau.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

nlands
>=20
> I can't seem to see a SATA drive on my 460EX Canyonlands=20
> board.  Did I miss something in the kernel configuration. =20
> The drive is a Seagate Baracuda  750M - ST3750330AS
>=20

Maybe, but on that board the SATA and PCI-E 1L are shared and there is a
jumper to pick which one you want.

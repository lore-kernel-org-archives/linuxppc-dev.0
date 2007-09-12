Return-Path: <silvio.fricke@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 52D0CDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 04:30:48 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so324285uge
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:30:47 -0700 (PDT)
Date: Wed, 12 Sep 2007 20:30:38 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
Message-ID: <20070912183038.GA5682@sfrouter>
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> > I have looked up "kernel/irq/manage.c". "-ENOSYS" is returned on functi=
on
> > "setup_irq" because the used irq(MPC52xx_IRQ2) is the same as no_irq_ch=
ip.
> >
> > THE MPC52xx_IRQ2 is a excerpt from "include/ppc/mpc52xx.h" (per copy
> > paste), but mpc52xx is (now) a powerpc-arch. What is the desired value =
for
> > IRQ-2 on a mpc5200b?
>=20
> The irq number you pass into request_irq is a system-wide irq number;
> it doesn't necessarily map directly onto the MPC52xx irq number.
> Typically, you'd have a node for your device in the device tree which
> has a phandle back to the interrupt node and you would use
> irq_of_parse_and_map() to map it back to a system-wide irq number.

The IRQ-pin-2 belongs to "PIN-configuration-nodes" described in
"booting-without-of.txt"? Than, what is the QE for my MPC5200B?

Can u give me an example with a single IRQ of a configuration-node for a
dts?


TIA:
Silvio

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
----------------------------------------------------------------------------


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG6DBO8WEBxatmn40RAvFHAJ4my1CLjuuhG3GMYR8pzQ4CpeAQWACcD+xv
ExdIhzz/zKXqnKOfrv813rQ=
=HoXB
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

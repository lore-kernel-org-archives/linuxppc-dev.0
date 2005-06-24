Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 351A367A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Jun 2005 01:45:22 +1000 (EST)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AWdYhqJMALQmI8gPcKV9"
Date: Fri, 24 Jun 2005 11:33:09 -0400
Message-ID: <1119627190.28058.39.camel@jmcmullan.timesys>
MIME-Version: 1.0
Date: Fri, 24 Jun 2005 11:25:18 -0400
Message-ID: <1119627190.28058.39.camel@jmcmullan.timesys>
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: <vbordug@mvista.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: PQ2FADS PCI Interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-AWdYhqJMALQmI8gPcKV9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

(This is mainly for Vitaly B., but others may be interested)

Given your latest MPC82xx PCI patches to the list, PCI support
is *better*, but interrupts are *not* delivered on the PQ2FADS

One question I have, is that it seems that on the MPC8280, at
least, the PCI interrupt vector is 0x12, not the SIU_INT6=20
vectors, according to MPC8280RM.pdf, Table 4-3 on page 4-16.

Vitaly, where are places in your PCI patch where you were
uncertain of board differences between the PQ2FADS and the
MPC8272ADS, so that I can verify those first?

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-AWdYhqJMALQmI8gPcKV9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCvCe18/0vJ5szK6kRArJcAKCR4ZrscPd4MU5PNvzoSi5v+SAQ/gCeJYI1
lk6fMJgdvyBxKdxhy/kaUOU=
=qjji
-----END PGP SIGNATURE-----

--=-AWdYhqJMALQmI8gPcKV9--

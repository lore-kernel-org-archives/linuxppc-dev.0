Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3A10DDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 05:29:34 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc: fix comment in kernel/irq.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17799.31574.736052.865096@cargo.ozlabs.ibm.com>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.859071000@sipsolutions.net>
	<17799.31574.736052.865096@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bi3zkOKh5v5mnIRghAXt"
Date: Tue, 19 Dec 2006 19:29:34 +0100
Message-Id: <1166552974.6916.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-bi3zkOKh5v5mnIRghAXt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-19 at 16:40 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> > numbers, but this is actually dependent on configuration options now.
> > Replace by NO_IRQ and NO_IRQ_ENABLED.
>=20
> Hmmm, NO_IRQ has to be 0, if anything, per decree of the head penguin.

I thought so too but then I found that under some conditions it's
actually defined to -1, so I was confused. Maybe that is wrong then?

johannes

--=-bi3zkOKh5v5mnIRghAXt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFiC+O/ETPhpq3jKURAs9yAKCD+uYC8w+RXhZM1go9zQhuNOHbPQCgm1Nd
nelyB4QTARNQ4S4n42cGRTY=
=BkxK
-----END PGP SIGNATURE-----

--=-bi3zkOKh5v5mnIRghAXt--

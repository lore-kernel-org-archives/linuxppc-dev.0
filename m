Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93190DDF9C
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 03:05:32 +1100 (EST)
Date: Sat, 21 Feb 2009 17:05:04 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 01/13] sdhci: Add quirk for controllers with no
	end-of-busy IRQ
Message-ID: <20090221170504.657ff791@mjolnir.ossman.eu>
In-Reply-To: <20090220173308.GA7583@oksana.dev.rtsoft.ru>
References: <20090220173228.GA5091@oksana.dev.rtsoft.ru>
	<20090220173308.GA7583@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-16056-1235232310-0001-2"
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-16056-1235232310-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2009 20:33:08 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> From: Ben Dooks <ben-linux@fluff.org>
>=20
> The Samsung SDHCI (and FSL eSDHC) controller block seems to fail
> to generate an INT_DATA_END after the transfer has completed and
> the bus busy state finished.
>=20
> Changes in e809517f6fa5803a5a1cd56026f0e2190fc13d5c to use the
> new busy method are the cause of the behaviour change.
>=20
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Any objections to me merging this right away? It is needed for another
controller.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-16056-1235232310-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAkmgJjYACgkQ7b8eESbyJLjETgCgsJi+RmPSnZ4hyM/0HMbEGGXS
UNUAmQHl8pQ0tqXFhrfcEcN+QThpB956
=y4YH
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-16056-1235232310-0001-2--

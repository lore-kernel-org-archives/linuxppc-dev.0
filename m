Return-Path: <pierre@ossman.eu>
Received: from smtp.ossman.eu (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F4037DDDE1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 05:57:21 +1000 (EST)
Date: Wed, 3 Jun 2009 21:57:09 +0200
From: Pierre Ossman <pierre@ossman.eu>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] mmc: Fix the wrong accessor to HOSTVER register
Message-ID: <20090603215709.185d2a6b@mjolnir.ossman.eu>
In-Reply-To: <20090602172644.GA26721@oksana.dev.rtsoft.ru>
References: <1241606407-18685-1-git-send-email-daveliu@freescale.com>
	<20090602172644.GA26721@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.ossman.eu-31122-1244059033-0001-2"
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx, ben-linux@fluff.org,
	drzeus-sdhci@drzeus.cx
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

--=_freyr.ossman.eu-31122-1244059033-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jun 2009 21:26:44 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Wed, May 06, 2009 at 06:40:07PM +0800, Dave Liu wrote:
> > Freescale eSDHC controller has the special order for
> > the HOST version register. that is not same as the other's
> > registers. The address of HOSTVER in spec is 0xFE, and
> > we need use the in_be16(0xFE) to access it, not in_be16(0xFC).
> >=20
> > Signed-off-by: Dave Liu <daveliu@freescale.com>
>=20
> Sorry for the delay Dave. This patch is surely
>=20
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>=20

Queued.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-31122-1244059033-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkom1ZkACgkQ7b8eESbyJLhMhQCfeCMd15HjnbV6BHTM+E1Dd01g
tjQAnj6w+9lHY3NBLmaA4MZdRpJeUlSA
=+cKD
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-31122-1244059033-0001-2--

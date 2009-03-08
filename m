Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48A8BDDF81
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 01:52:49 +1100 (EST)
Date: Sun, 8 Mar 2009 15:44:35 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 11/11] mmc: Add OpenFirmware bindings for SDHCI driver
Message-ID: <20090308154435.41aa2dde@mjolnir.ossman.eu>
In-Reply-To: <20090305202850.GK28709@oksana.dev.rtsoft.ru>
References: <20090305202737.GA24166@oksana.dev.rtsoft.ru>
	<20090305202850.GK28709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-22905-1236523479-0001-2"
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
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

--=_freyr.drzeus.cx-22905-1236523479-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Mar 2009 23:28:50 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This patch adds a new driver: sdhci-of. The driver is similar to
> the sdhci-pci, it contains common probe code, and controller-specific
> ops and quirks.
>=20
> So far there are only Freescale eSDHC ops and quirks.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/Kconfig    |   10 ++
>  drivers/mmc/host/Makefile   |    1 +
>  drivers/mmc/host/sdhci-of.c |  309 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 320 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-of.c
>=20

I'd like a MAINTAINERS entry for this (sub)driver.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-22905-1236523479-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkmz2dcACgkQ7b8eESbyJLgmiACgkrBrEsUvnUPlVAopTf97VJer
udMAoOdfs2neHg/1cKR0Eckqsp5QFbtT
=nIKS
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-22905-1236523479-0001-2--

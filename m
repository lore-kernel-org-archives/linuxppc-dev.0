Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0677DDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 08:06:58 +1100 (EST)
Date: Sun, 8 Feb 2009 22:06:47 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 09/11] sdhci: Add set_clock callback
Message-ID: <20090208220647.33022d92@mjolnir.drzeus.cx>
In-Reply-To: <20090206180659.GI11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180659.GI11548@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_freyr.drzeus.cx-4745-1234127211-0001-2"
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

--=_freyr.drzeus.cx-4745-1234127211-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2009 21:06:59 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> FSL eSDHC hosts have incompatible register map to manage the SDCLK.
> This patch adds set_clock callback so that drivers could overwrite
> set_clock behaviour.
>=20
> Similar patch[1] was posted by Ben Dooks, though in Ben's version the
> callback is named change_clock, plus the patch has some unrelated bits
> that makes the patch difficult to reuse.
>=20
> [1] http://lkml.org/lkml/2008/12/2/160
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

A set_clock() callback is reasonable as there might be a clock source
that needs to be set up, but completely overriding the normal routine
(i.e. the "return") should be quirked IMO.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-4745-1234127211-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmPSWoACgkQ7b8eESbyJLgXRgCgvtck8mukBbgKNWOIOKo4Ot07
gy0AoLjU6SR0saqGyhnMXmABQjtryjRB
=deMA
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-4745-1234127211-0001-2--

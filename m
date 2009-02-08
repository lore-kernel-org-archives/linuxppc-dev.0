Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD479DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 08:04:52 +1100 (EST)
Date: Sun, 8 Feb 2009 22:04:40 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 08/11] sdhci: Add support for hosts that don't specify
	clocks in the cap. register
Message-ID: <20090208220440.55574c7c@mjolnir.drzeus.cx>
In-Reply-To: <20090206180657.GH11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180657.GH11548@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_freyr.drzeus.cx-4612-1234127085-0001-2"
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

--=_freyr.drzeus.cx-4612-1234127085-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2009 21:06:57 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> FSL eSDHC hosts don't provide clocks bits in the capabilities register,
> instead we're getting clocks values from the device tree.
>=20
> There is somewhat similar change[1] from Ben Dooks, the change adds
> callbacks for getting the clocks. But for eSDHC the callbacks are
> superfluous, since the clocks are static.
>=20
> [1] http://lkml.org/lkml/2008/12/2/157
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

As I told Ben, I prefer if we stick to the standard as much as
possible. So no external info unless the register is set to zero.

And since we know the Samsung chip needs callbacks, we might as well
add them here. It's not like this is a performance critical path.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-4612-1234127085-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmPSOwACgkQ7b8eESbyJLi8wwCgj68xkWjqxJwk5rYITzCQ7m+x
7ukAn1HgqvWBje3lywOUsMetuNQf8QLr
=liEN
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-4612-1234127085-0001-2--

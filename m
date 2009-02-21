Return-Path: <drzeus@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09F9BDDF00
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 03:01:19 +1100 (EST)
Date: Sat, 21 Feb 2009 17:01:06 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/13] FSL eSDHC support
Message-ID: <20090221170106.53426838@mjolnir.ossman.eu>
In-Reply-To: <20090220173228.GA5091@oksana.dev.rtsoft.ru>
References: <20090220173228.GA5091@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.drzeus.cx-15573-1235232073-0001-2"
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

--=_freyr.drzeus.cx-15573-1235232073-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2009 20:32:28 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Hi all,
>=20
> Some updates for the eSDHC support:
>=20

I think the patches are coming along nicely. If we can just sort out
the accessors, then it should be ready for -next. It pokes around quite
a bit in the sdhci driver though, so I'd like it to stay there for one
cycle and (hopefully) be merged for 2.6.31.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-15573-1235232073-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAkmgJUkACgkQ7b8eESbyJLgy2wCg8ohDidGvy5CliUpOHGMXf3Bk
HZwAn2CwEDbZBW9yPlSeFrugNfzuLruN
=bNS+
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-15573-1235232073-0001-2--

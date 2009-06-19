Return-Path: <pierre@ossman.eu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D0B69B7268
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 05:21:43 +1000 (EST)
Date: Fri, 19 Jun 2009 21:21:26 +0200
From: Pierre Ossman <pierre@ossman.eu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2] sdhci: Add support for hosts that are only capable
	of 1-bit transfers
Message-ID: <20090619212126.51f00410@mjolnir.ossman.eu>
In-Reply-To: <20090617201408.GA17909@oksana.dev.rtsoft.ru>
References: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
	<20090617201408.GA17909@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.ossman.eu-10961-1245439293-0001-2"
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-10961-1245439293-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2009 00:14:08 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Some hosts (hardware configurations, or particular SD/MMC slots) may
> not support 4-bit bus. For example, on MPC8569E-MDS boards we can
> switch between serial (1-bit only) and nibble (4-bit) modes, thought
> we have to disable more peripherals to work in 4-bit mode.
>=20
> Along with some small core changes, this patch modifies sdhci-of
> driver, so that now it looks for "sdhci,1-bit-only" property in the
> device-tree, and if specified we enable a proper quirk.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Patch merged.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-10961-1245439293-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAko75TsACgkQ7b8eESbyJLjnCQCgpi+OBuDgbVeXA/kbe/05DMjr
fkMAmwTTre9FzrxDhLx6jZleEUU04pjU
=jwjH
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-10961-1245439293-0001-2--

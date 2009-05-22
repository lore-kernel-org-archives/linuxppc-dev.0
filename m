Return-Path: <pierre@ossman.eu>
Received: from smtp.ossman.eu (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C013DE18B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 21:53:25 +1000 (EST)
Date: Fri, 22 May 2009 13:53:11 +0200
From: Pierre Ossman <pierre@ossman.eu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mmc: Add fsl,esdhc as a valid compatible to bind against
Message-ID: <20090522135311.090c98ad@mjolnir.ossman.eu>
In-Reply-To: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
References: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature";
	boundary="=_freyr.ossman.eu-27028-1242993197-0001-2"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
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

--=_freyr.ossman.eu-27028-1242993197-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  8 May 2009 08:52:49 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> We plan to use fsl,esdhc going forward as the base compatible so update
> the driver to bind against it.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---

Applied.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-27028-1242993197-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoWkisACgkQ7b8eESbyJLhE+QCgx/oYiz4LFnd/vFcKWiR4+DDI
jr4An3yUIoLOURJm4SpcgdQlWbZeRSZB
=J8Hr
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-27028-1242993197-0001-2--

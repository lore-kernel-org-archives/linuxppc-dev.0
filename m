Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCFE3DDDA9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 12:38:40 +1000 (EST)
Subject: Re: [PATCH] mmc: Add fsl,esdhc as a valid compatible to bind against
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
References: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-M1ErhluxqEqVgYsgIrEP"
Date: Mon, 11 May 2009 12:38:39 +1000
Message-Id: <1242009519.7767.44.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, pierre@ossman.eu, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-M1ErhluxqEqVgYsgIrEP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-05-08 at 08:52 -0500, Kumar Gala wrote:
> We plan to use fsl,esdhc going forward as the base compatible so update
> the driver to bind against it.

I was going to NAK this based on its non-sensical changelog, but going
backward you're not the first to be going forward :)

cheers


--=-M1ErhluxqEqVgYsgIrEP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoHj68ACgkQdSjSd0sB4dId0QCfapWMz/du/dhVKytbJqFwZs1+
S6oAoLfNypy4V6w9jvFUVxxy2GzosZhE
=RAy6
-----END PGP SIGNATURE-----

--=-M1ErhluxqEqVgYsgIrEP--

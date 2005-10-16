Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dorchain.net", Issuer "Dorchain Family" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DA2EE6855F
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Oct 2005 18:24:29 +1000 (EST)
Date: Sun, 16 Oct 2005 10:17:59 +0200
From: Joerg Dorchain <joerg@dorchain.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051016081759.GA2609@Redstar.dorchain.net>
References: <20051014123823.GA9477@Redstar.dorchain.net>
	<1129327105.21765.39.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <1129327105.21765.39.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2005 at 07:58:25AM +1000, Benjamin Herrenschmidt wrote:
>=20
> This looks like a bug that was introduced by linus in 2.6.13 and that I
> _think_ should be fixed in the stable series, so if you get 2.6.13.x (x
> =3D latest stable release) it should work.

2.6.13.4 does not fix it and(, as far as I skimmed it,) contains no
changes to the ati framebuffer code.
>=20
> Usually, to debug those crashes, I'm adding a hack to kernel/printk.c to
> call btext_drawstring() (with some test to make sure to do that not too
> early, typically only after setup_arch has been called).

Thanks,

Joerg

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDUgy3jY4+4PdzvOARAn7WAJ9Aq4/gTN6YhjpheJ7yJ8GlMoF+JgCdEKru
cxhl+weRT6yie6GalKyHHXc=
=qr+Y
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

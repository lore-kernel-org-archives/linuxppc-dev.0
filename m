Return-Path: <wolfi@mittelerde.physik.uni-konstanz.de>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0FB0679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 23:32:42 +1000 (EST)
Date: Thu, 2 Jun 2005 15:05:02 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050602130502.GA6151@halley.zuhause>
References: <1117424155.5228.28.camel@gaston>
	<3db27390050530145939d260e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <3db27390050530145939d260e4@mail.gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, May 30, 2005 at 11:59:14PM +0200, Mickael Royer wrote:
> Hi Ben
>=20
> > Ok, the patch is now getting "good enough" for wider testing. It applies
> > on current "git" tree (or 2.6.12-rc6 when/if that is ever released).
>=20
> I have just tested your patch with the 2.5.12-rc5-git5 on the new powerbo=
ok 12".
> And yes, the suspend to disk works very well, even if X is running (I
> report my problem with X and the suspend to disk with a 2.6.12-rc4 in
> another discussion).
> It is really good.=20
>=20
> Thanks for your good job Ben.=20
>=20
> Mickael
>=20
> On 5/30/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Ok, the patch is now getting "good enough" for wider testing. It applies
> > on current "git" tree (or 2.6.12-rc6 when/if that is ever released). It
> > requires one other patch to be applied first:
> >=20
> > http://gate.crashing.org/~benh/ppc32-remove-macserial.diff
> >=20
> > The PM patch itself can be found at:
> >=20
> > http://gate.crashing.org/~benh/ppc32-rework-pm.diff
> >=20
> > This patch completely reworks both suspend-to-ram and suspend-to-disk
> > support on PowerMac:
[...snip...]

Today I applied the two mentioned patches to rc5-git6. There were quite
a lot of offsets and one time fuzz 2 (hunk 10 in via-pm.c). But still I
get a freeze on my PowerBook6,2 (12", 1Ghz from Dec. 2004) when I
suspend to disk from X. If I suspend from tty1 the first time, the
following suspends work well even from X.

Thanks for your work,

Wolfi

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCnwP+H0o2mefAfsQRArP4AKCMHUz3Ww0Lz5MTyUMxkrXuERGH0QCeJQsS
Ng9/qPc6xuaRyNkGd5YEuQk=
=Wu/G
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

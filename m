Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] device-tree: Drop properties with "/" in their name
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <0958c243b32f5f77028a794a9ce0d55f9a12121e.1274272289.git.michael@ellerman.id.au>
References: <0958c243b32f5f77028a794a9ce0d55f9a12121e.1274272289.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-tv1GEK1aO+GUuk5m8HOe"
Date: Thu, 20 May 2010 23:51:07 +1000
Message-ID: <1274363467.16617.1.camel@concordia>
Mime-Version: 1.0
Cc: lists@nerdbynature.de, microblaze-uclinux@itee.uq.edu.au, monstr@monstr.eu
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-tv1GEK1aO+GUuk5m8HOe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-19 at 22:32 +1000, Michael Ellerman wrote:
> Some bogus firmwares include properties with "/" in their name. This
> causes problems when creating the /proc/device-tree file system,
> because the slash is taken to indicate a directory.
>=20
> We don't care about those properties, and we don't want to encourage
> them, so just throw them away when creating /proc/device-tree.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>=20
> Hi Christian, if you could test this new patch that'd be great, thanks!

And thanks to Christian for testing it:

https://bugzilla.kernel.org/show_bug.cgi?id=3D15589

Tested-by: Christian Kujau <lists@nerdbynature.de>


cheers

--=-tv1GEK1aO+GUuk5m8HOe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkv1PkgACgkQdSjSd0sB4dLlQACfSL9A1PcAY1Cka88nJcLqRJqm
CVUAni5fLcc8C9ZqTGNhCtEZ7Onbu8pQ
=13Pe
-----END PGP SIGNATURE-----

--=-tv1GEK1aO+GUuk5m8HOe--

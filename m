Return-Path: <michael@ellerman.id.au>
Subject: Re: ppc64 vecemu compile failure
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080130005607.GA32622@lixom.net>
References: <20080130000337.GC25253@stro.at> <20080130005607.GA32622@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0/pELYRWRAXITr0OeFbv"
Date: Wed, 30 Jan 2008 12:39:25 +1100
Message-Id: <1201657165.15799.0.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>,
	maximilian attems <max@stro.at>, Paul Mackerras <paulus@au.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0/pELYRWRAXITr0OeFbv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2008-01-29 at 18:56 -0600, Olof Johansson wrote:
> Hi,
>=20
> On Wed, Jan 30, 2008 at 01:03:37AM +0100, maximilian attems wrote:
> > on latest git since driver subsys merge on powerpc64:
> >=20
> > arch/powerpc/kernel/built-in.o: In function `fphalf':
> > vecemu.c:(.toc+0x1360): undefined reference to `devices_subsys'
> > make[3]: *** [.tmp_vmlinux1] Error 1

> It's a known problem, fixed by:
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16491

But begs the question, why is the linker lying to use about vecemu.c
using devices_subsys?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0/pELYRWRAXITr0OeFbv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHn9VNdSjSd0sB4dIRAkiTAKC+D0g6I+VjxDEAHfXX3FFgxu4CCgCfdnED
jkFYWnRxNxUz+7hLWSHDBAc=
=jK8s
-----END PGP SIGNATURE-----

--=-0/pELYRWRAXITr0OeFbv--

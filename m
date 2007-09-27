Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0709260937540.6243@pademelon.sonytel.be>
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
	<46F9B454.8010004@au1.ibm.com>
	<1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
	<46F9E67C.4070209@au1.ibm.com>
	<8FC0C4ED-3268-467C-A3EF-0336082062E1@kernel.crashing.org>
	<Pine.LNX.4.62.0709260937540.6243@pademelon.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lYEtyzLdPYUQnLv5EFrk"
Date: Thu, 27 Sep 2007 12:53:56 +1000
Message-Id: <1190861636.6502.13.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Carlos Eduardo Seo <eduseo@br.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-lYEtyzLdPYUQnLv5EFrk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-09-26 at 09:42 +0200, Geert Uytterhoeven wrote:
> On Wed, 26 Sep 2007, Kumar Gala wrote:
> > On Sep 25, 2007, at 11:56 PM, Mark Nelson wrote:
> > > What cores have SPE at the moment? Also, perhaps more importantly, =20
> > > are there any plans to have Altivec and SPE in the same core?
> >=20
> > The e500 cores's from Freescale.
> >=20
> > No, they are pretty much mutually exclusive.
>=20
> Bummer, only now do I realize this thread is not about the Synergistic
> Processing Elements but about the Signal Processing Extension...

Yeah, it's a bit of a downer. Luckily most of the Cell kernel code uses
SPU rather than SPE.

Happily it looks like SPU will become ambiguous if Niagara II support
lands in the kernel:
http://realworldtech.com/page.cfm?ArticleID=3DRWT090406012516&p=3D2

sigh :)

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-lYEtyzLdPYUQnLv5EFrk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+xtEdSjSd0sB4dIRAsHHAJ4hCSzwb0Bz/t7uta4lG6MZJK9zWgCfXqC0
T5AWYJXpyUQ1RvqKVkQUZ6Q=
=9wKS
-----END PGP SIGNATURE-----

--=-lYEtyzLdPYUQnLv5EFrk--

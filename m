Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:46:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: Do we need to reset the master branch?
Message-Id: <20070720014618.a6eec3eb.sfr@canb.auug.org.au>
In-Reply-To: <20070720014432.a46164a8.sfr@canb.auug.org.au>
References: <20070719151746.GB20538@mag.az.mvista.com>
	<20070720012708.91c77527.sfr@canb.auug.org.au>
	<20070719153217.GC20538@mag.az.mvista.com>
	<20070720014432.a46164a8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__20_Jul_2007_01_46_18_+1000_ijvDmu1_3jHkQ//B"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__20_Jul_2007_01_46_18_+1000_ijvDmu1_3jHkQ//B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jul 2007 01:44:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> git remote add powerpc git://git.kernel.org/pub/scm/linux/kernel/git/paul=
us/powerpc.git
> git fetch powerpc
>=20
> This will track the tree in branches called powerpc/<branch> and do
> resets as necessary.

You should not make any local commits to the powerpc/* branches, of course.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__20_Jul_2007_01_46_18_+1000_ijvDmu1_3jHkQ//B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGn4dPTgG2atn1QN8RAtd1AKCDTF48O3/XPNdwiClg812DUsU7VACgis5t
JLXwtT5BZCFMK579mx+M+EY=
=kRVz
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Jul_2007_01_46_18_+1000_ijvDmu1_3jHkQ//B--

Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 26CBBB7D03
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 11:08:51 +1100 (EST)
Date: Thu, 28 Jan 2010 11:08:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Dynamically allocate pacas
Message-Id: <20100128110846.7a9f8941.sfr@canb.auug.org.au>
In-Reply-To: <8748.1264634853@neuling.org>
References: <c22a0fd3d76675813ce5f1596d80614aee80ed24.1264568410.git.michael@ellerman.id.au>
	<4389.1264575576@neuling.org> <1264632445.6352.6.camel@concordia>
	<8748.1264634853@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Jan_2010_11_08_46_+1100_PmLRqmS1f/FKBlXj"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__28_Jan_2010_11_08_46_+1100_PmLRqmS1f/FKBlXj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jan 2010 09:57:33 +1030 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> > > Putting an #include <asm/paca.h> at the top of setup-common.c fixes i=
t.
> >=20
> > Gah, I saw it was coming via somewhere else but decided not to add it,
> > wrong decision :)

Always the wrong decision, Mr Ellerman :-)

> IMHO, if it's used we should put it in.  Otherwise some other random
> include file will remove it and break us.

I see this a lot in linux-next builds ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Jan_2010_11_08_46_+1100_PmLRqmS1f/FKBlXj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktg1Y4ACgkQjjKRsyhoI8yfHgCeJKjzyFcl8x4hHSzpPGr8B67Y
rsAAoIj9d/X0wBlaps4YHpZBkGtkxyL/
=9TgA
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Jan_2010_11_08_46_+1100_PmLRqmS1f/FKBlXj--

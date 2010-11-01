Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CA8FBB70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 08:26:45 +1100 (EST)
Date: Tue, 2 Nov 2010 08:26:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] iSeries: Remove unused mf_getSrcHistory function.
Message-Id: <20101102082634.65342ce6.sfr@canb.auug.org.au>
In-Reply-To: <alpine.LNX.2.00.1011012104050.12889@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1010301911220.1572@swampdragon.chaosbits.net>
	<1288609842.10671.7.camel@concordia>
	<20101102071025.2fe5e6ca.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1011012104050.12889@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__2_Nov_2010_08_26_34_+1100_U=uMosM.7D1l0yWN"
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__2_Nov_2010_08_26_34_+1100_U=uMosM.7D1l0yWN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Nov 2010 21:06:23 +0100 (CET) Jesper Juhl <jj@chaosbits.net> wrot=
e:
>
> Remove unused function 'mf_getSrcHistory' (that will never be used ever=20
> according to Stephen Rothwell).
>=20
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__2_Nov_2010_08_26_34_+1100_U=uMosM.7D1l0yWN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMzzCKAAoJEDMEi1NhKgbsKmsH+QEPkwGHkXRBXloJgEw95dOI
m8BvAkU4uA0+n/ZHJw/LFoSdCj3oD2uI/RT+p9rHXmkIgAa9kFbEY9VHyDD2L3DY
oWuLFNpbZm0xyOJ/U+WKxz+CgEqB3hcfg3A8VZ4X2mDC/YuT73CbP0NBldDNOpTj
crAsfSgwEp7/Prodnrz/RZCX6Zpkwqn2zlph7iR6w0RRRtqouu72507rBAvo9/Tt
YqZQVw2MOkZB0WpHZjzS7QWhWqMlYFCwQZ+JkL/+gQLEUezPnfwVQgp2vsPzeCwm
Dan+O9XfajsWlICgHzRM/1P6B7quQHttxNjUbLFpoNKoSsmS9NPYfrQU0jcCBkE=
=MynW
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Nov_2010_08_26_34_+1100_U=uMosM.7D1l0yWN--

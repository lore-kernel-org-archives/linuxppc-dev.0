Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 62461DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 10:12:19 +1100 (EST)
Date: Wed, 3 Dec 2008 10:12:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nicolas Palix <npalix@diku.dk>
Subject: Re: [PATCH linux-next] drivers/hvc: Add missing of_node_put
Message-Id: <20081203101210.01e5afab.sfr@canb.auug.org.au>
In-Reply-To: <200812021438.56071.npalix@diku.dk>
References: <200812021438.56071.npalix@diku.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__3_Dec_2008_10_12_10_+1100_gFO3uuU0vpljGhti"
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Julia Lawall <julia@diku.dk>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__3_Dec_2008_10_12_10_+1100_gFO3uuU0vpljGhti
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Dec 2008 14:38:55 +0100 Nicolas Palix <npalix@diku.dk> wrote:
>
> of_node_put is needed before discarding a value received from
> of_find_node_by_name, eg in error handling code or when the device
> node is no longer used.
>=20
> Signed-off-by: Nicolas Palix <npalix@diku.dk>
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__3_Dec_2008_10_12_10_+1100_gFO3uuU0vpljGhti
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk1wMoACgkQjjKRsyhoI8wocgCbBRRR++quM8rPQ8ALskadujgI
c3gAnjUNkQRwlDZ/aAbsdpdGCnaEslfQ
=8UdU
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Dec_2008_10_12_10_+1100_gFO3uuU0vpljGhti--

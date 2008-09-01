Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C0AA6DDE21
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 12:55:16 +1000 (EST)
Date: Mon, 1 Sep 2008 12:55:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc: use sys_pause for 32bit pause entry point
Message-Id: <20080901125501.5b4c5e72.sfr@canb.auug.org.au>
In-Reply-To: <20080901012330.GA7544@lst.de>
References: <20080901012330.GA7544@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__1_Sep_2008_12_55_01_+1000_QBEkn2=UQ2vK1Ptt"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__1_Sep_2008_12_55_01_+1000_QBEkn2=UQ2vK1Ptt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Sep 2008 03:23:30 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> sys32_pause is a useless copy of the generic sys_pause.
>=20
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__1_Sep_2008_12_55_01_+1000_QBEkn2=UQ2vK1Ptt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki7WYUACgkQjjKRsyhoI8wTYACfeX+gpIDCUiZU+M/J9OSvxAfM
1mkAmgLG3dswJps7Z8RWROnmG3GRVdxh
=BlQD
-----END PGP SIGNATURE-----

--Signature=_Mon__1_Sep_2008_12_55_01_+1000_QBEkn2=UQ2vK1Ptt--

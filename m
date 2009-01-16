Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A35E1474CD
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 09:46:33 +1100 (EST)
Date: Sat, 17 Jan 2009 09:46:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] infiniband/ehca: use consistent type
Message-Id: <20090117094625.1500c8e7.sfr@canb.auug.org.au>
In-Reply-To: <adazlhqdgk4.fsf@cisco.com>
References: <20081231141453.45d7f2c1.sfr@canb.auug.org.au>
	<adazlhqdgk4.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__17_Jan_2009_09_46_25_+1100_3vbBFOXhAgIzdiCj"
Cc: Heiko J Schick <schickhj@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__17_Jan_2009_09_46_25_+1100_3vbBFOXhAgIzdiCj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Fri, 16 Jan 2009 14:36:27 -0800 Roland Dreier <rdreier@cisco.com> wrote:
>
> I'm going to apply this for 2.6.29, since the change to the u64 type
> went upstream, so ehca spews a bunch of warnings now.

Thanks.

> I'll also add the following patch to fix all the printk format warnings:
>=20
> IB/ehca: Fix printk format warnings from u64 type change

Sorry to appear picky, but how is that different from the patch "powerpc:
cleanup from powerpc l64 to ll64 change: drivers/infiniband" that I sent
to you on Jan 7?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__17_Jan_2009_09_46_25_+1100_3vbBFOXhAgIzdiCj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklxDkEACgkQjjKRsyhoI8w/7wCbBienmv7xzp7v8wPdf4H9ybhK
CUQAn3XDuOTW3ZdG11oA5+XYfvu60MDB
=ptNm
-----END PGP SIGNATURE-----

--Signature=_Sat__17_Jan_2009_09_46_25_+1100_3vbBFOXhAgIzdiCj--

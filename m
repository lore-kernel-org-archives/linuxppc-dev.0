Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F1BACDDEBF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 14:18:38 +1100 (EST)
Date: Tue, 8 Jan 2008 14:18:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 2/8] pseries: phyp dump: config file
Message-Id: <20080108141827.403bc8cc.sfr@canb.auug.org.au>
In-Reply-To: <4782C0C8.2050702@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C0C8.2050702@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_14_18_27_+1100_61NaMp2EcUEwNZIm"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_14_18_27_+1100_61NaMp2EcUEwNZIm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jan 2008 18:16:08 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
>=20
> Add hypervisor-assisted dump to kernel config
>=20
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

This patch should probably come last in the series so that all the code
is there before some bisecting autobuilder tries to configure it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_14_18_27_+1100_61NaMp2EcUEwNZIm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHguuITgG2atn1QN8RAj9lAKCAWhiDWj/e9og+DO3hVjTT9wKSVwCfUBLU
hrMRln7KmrHEATjPckGFt+c=
=c3Pd
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_14_18_27_+1100_61NaMp2EcUEwNZIm--

Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 88C89DDD09
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 20:57:03 +1000 (EST)
Date: Fri, 21 Sep 2007 20:56:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/11] [POWERPC] iSeries: move detection of virtual tapes
Message-Id: <20070921205645.997634bb.sfr@canb.auug.org.au>
In-Reply-To: <20070921082952.GA5607@lst.de>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
	<20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
	<20070921143446.ad55d494.sfr@canb.auug.org.au>
	<20070921143540.75f3becf.sfr@canb.auug.org.au>
	<20070921143647.7ceebabc.sfr@canb.auug.org.au>
	<20070921143750.4114b0b5.sfr@canb.auug.org.au>
	<20070921143841.37ad2a2f.sfr@canb.auug.org.au>
	<20070921082952.GA5607@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Sep_2007_20_56_45_+1000_GgfvHSCL4TJf3A_2"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Sep_2007_20_56_45_+1000_GgfvHSCL4TJf3A_2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Sep 2007 10:29:52 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> I think we should generate these device tree entires unconditionally.
> They're just a conversion of what the iseries firmware/hypervisor
> provides and not dependent on a specific driver.
>=20
> (dito for the other patches with the same scheme)

You are right, of course. I will redo the relevant patches.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Sep_2007_20_56_45_+1000_GgfvHSCL4TJf3A_2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG86N1TgG2atn1QN8RAnv1AJ47sEA4bMHTpQnVHh/+/mK9GowLuQCfXHD6
8ELXdorz5PwJgoWOrA7CdUM=
=2/7K
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Sep_2007_20_56_45_+1000_GgfvHSCL4TJf3A_2--

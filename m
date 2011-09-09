Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8CBEB70BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 23:09:03 +1000 (EST)
Date: Fri, 9 Sep 2011 15:08:55 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Message-ID: <20110909130855.GR1912@pengutronix.de>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	<20110909114004.GP1912@pengutronix.de>
	<2239AC579C7D3646A720227A37E026811A22BD@039-SN1MPN1-005.039d.mgd.msft.net>
	<20110909123324.GQ1912@pengutronix.de>
	<2239AC579C7D3646A720227A37E026811A2311@039-SN1MPN1-005.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eyYj78xbwv+yMvU1"
In-Reply-To: <2239AC579C7D3646A720227A37E026811A2311@039-SN1MPN1-005.039d.mgd.msft.net>
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"cjb@laptop.org" <cjb@laptop.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eyYj78xbwv+yMvU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Previously, I sent this patch together  with another one. But
> technically they are separated patches.  I got some comments from
> Anton about the patch. I will try to address the comment. but for this
> one, it is a stand along patch. I'd like to push it first.

Okay.

> I do not see any comment about byte swapping about this patch.
> you may have mis-understanding here.

I was misguided, yes, sorry. BE/LE issues with additional byteswapping
are a mind twister :/ Having a second look, it looks okay to me. One
could think about putting this into sdhci_platform as well, but this can
be done later if needed. Sadly, I currently don't have hardware to test
it.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eyYj78xbwv+yMvU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5qD+cACgkQD27XaX1/VRubIACgopSfpZCL5tDlkpdGGE0i2qla
s1cAnjosG/RlaaGzhli707im1SOCRZBI
=0AAa
-----END PGP SIGNATURE-----

--eyYj78xbwv+yMvU1--

Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E233A1007F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 20:10:31 +1100 (EST)
Date: Tue, 22 Mar 2011 10:10:27 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v6 6/6] powerpc, tqm5200: update tqm5200_defconfig to
	fit for charon board.
Message-ID: <20110322091027.GC2134@pengutronix.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<1300782452-528-7-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
In-Reply-To: <1300782452-528-7-git-send-email-hs@denx.de>
Cc: Ben Dooks <ben@simtec.co.uk>, linux-fbdev@vger.kernel.org,
	devicetree-discuss@ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>,
	Vincent Sanders <vince@simtec.co.uk>, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>     As this board is tqm5200 based, added necessary changes
>     to the tqm5200_defconfig. In previous patchserie I added
>     the changes to mpc5200_defconfig, as Wolfram Sang mentioned,
>     but as tqm5200_defconfig is in mainline, and the board is
>     tqm5200 based, I think, thats the appropriate place, as

I'd think the perfect solution would have been to merge the
tqm-defconfig into the mpc5200-defconfig entirely and get rid of it.
That being said, I don't think this issue is big enough to block this
series, so fine enough with me.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2IZ4MACgkQD27XaX1/VRu7cQCfWpwfinmAeGn8hGBfiiU0IqlG
MkoAoLaw5f0WowSPgUmyBzmU9YvG4B6b
=7p51
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--

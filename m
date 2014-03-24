Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88598140092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 01:25:29 +1100 (EST)
Date: Mon, 24 Mar 2014 14:49:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] i2c-cpm: Fix build by adding of_address.h and of_irq.h
Message-ID: <20140324134906.GF2631@katana>
References: <1395177024-5178-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
In-Reply-To: <1395177024-5178-1-git-send-email-scottwood@freescale.com>
Cc: Richard Weinberger <richard@nod.at>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 04:10:24PM -0500, Scott Wood wrote:
> Fixes a build break due to the undeclared use of irq_of_parse_and_map()
> and of_iomap().  This build break was apparently introduced while the
> driver was unbuildable due to the bug fixed by
> 62c19c9d29e65086e5ae76df371ed2e6b23f00cd ("i2c: Remove usage of
> orphaned symbol OF_I2C").  When 62c19c was added in v3.14-rc7,
> the driver was enabled again, breaking the powerpc mpc85xx_defconfig
> and mpc85xx_smp_defconfig.
>=20
> 62c19c is marked for stable, so this should go there as well.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: stable@kernel.org

Applied to for-current, thanks!


--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMDfSAAoJEBQN5MwUoCm2oK4P+wW4GDmNpjeqx6lMNCWRWKnH
mU2SyvyjwIZPntzhFOyJJw1Hze73dSZn5qJjALV2r8Clv9I2Z0xR4UrOTh0NBgu+
PyfMaypDFRtWYDbpiOn0dsHcdW3M/Rm0+VljmEa+8PirTsTDh7F4iRVG2pAx8mWm
cieaRCcdeqbewa2ln1DgB5eirT/yR5CT4osFAhSGZ7r0vBYw3aW48ItdvO6TMixs
gSiSyfeHJfa8/t8bPn6VzTDq18PsL+eDWUtL8dL64oP1ulOScbDDyJbQWrSf28hw
7Z2KEjBVguYVLVRZZ8jXJlmgOxxs5WFk1L+OK7yTGMHc/yBcQDQpD8KIYS1y+kN8
RmzSSBEVfCfdqGVyuMGJCMHAFHwXTPpSvvqxSv4MNV3zYyOSEKnAsEE+Iab4SvfX
Cp1rHXb+12UHNInRrbR2+VGxK3TQyPjoUsdp6bHX/MX3s5rubjNpE0NBljS37I6N
RTw4pZNceL5coPIAAuvOOGapP0U8u9DVSdFWpc13ssruYgIGGo8YeVYZiMylnEsU
LNptG6dFMb2LKmJpHyBY5kcWHWg8URDASlG8dCB+7BpkiBlTFJu/eN9eovI81e2s
BdFPnNRZhdfQPJThPkc1PYwypfa+gI0kZYe4g4iB4NhwmRxeAuDqw6kPdCI24Uen
XrhIUGwPCsQRHWvw/PiN
=3Thr
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--

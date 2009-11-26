Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id D11041007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 23:29:14 +1100 (EST)
Date: Thu, 26 Nov 2009 13:28:42 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/11] Yet another series of OF merge patches.
Message-ID: <20091126122842.GC4846@pengutronix.de>
References: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2009 at 01:17:41AM -0700, Grant Likely wrote:
> Nothing much to say here other than mostly mechanical merging of OF
> support code.  Some of it remains a little ugly, but I'm taking the
> approach of merging the code first, and refactoring it second.
>=20
> I've pushed this series out to my test-devicetree branch on my git
> server if anyone wants to test.  That branch also includes the
> previous 2 patch series that I've sent out.
>=20
> git://git.secretlab.ca/git/linux-2.6 test-devicetree
>=20
> Compile tested on: ppc64, ppc32, microblaze, sparc64, sparc32.
> Boot tested on mpc5200 (ppc32) platform.

test-devicetree as of today also works fine on my phyCORE-MPC5200B-IO.

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksOdHkACgkQD27XaX1/VRsPLgCgv0ZKmj3Ea/43SgVMA6CJ/tB0
zy0AoLrdXihljb6X17/9LaL0mQa7ugeS
=eVCc
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

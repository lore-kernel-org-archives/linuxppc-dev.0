Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 15 Oct 2009 12:00:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091015120007.3780c59b.sfr@canb.auug.org.au>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
References: <20091007041007.16890.62194.stgit@angua>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7"
Cc: monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Tue, 06 Oct 2009 22:29:57 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> Well, I've got to start somewhere...
>=20
> So here goes.  I've begun the work to merge and clean up the OF device
> tree handling code and this is my first set of patches.  Not fully
> tested yet, but I'm getting them out to the lists so that I can start
> responding to comments and collecting acks.  This first batch isn't
> anything exciting, just a merge of common code

This all looks OK to me.  One thing:  I started in this as well some time
ago and in my attempt I was hoping to avoid the ARCH ifdefs in linux/of.h
by creating asm/of.h and moving the differing bits in there ...

I'll send out the two patches I did just to show what I mean (these are
from before microblaze was using the OF stuff).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrWdBcACgkQjjKRsyhoI8w26gCgrC6aXsKjJZJN+rq7j8hhiiDb
ZK0AnRqc0bw0h1mbhMJ1vnCTuvoej99J
=ZMeC
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7--

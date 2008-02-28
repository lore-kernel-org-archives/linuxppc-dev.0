Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ED9EDDDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:00:50 +1100 (EST)
Date: Thu, 28 Feb 2008 11:00:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: FW: [PATCH] Xilinx: LL TEMAC/Bootstrap: Updated driver and
	bootstrap to pull mac addr from eeprom
Message-Id: <20080228110039.19f22d60.sfr@canb.auug.org.au>
In-Reply-To: <20080227231452.DD4124507B7@mail190-dub.bigfish.com>
References: <20080227231452.DD4124507B7@mail190-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Feb_2008_11_00_39_+1100_A_hV77=iTOJbe=DL"
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__28_Feb_2008_11_00_39_+1100_A_hV77=iTOJbe=DL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Wed, 27 Feb 2008 16:14:50 -0700 "John Linn" <John.Linn@xilinx.com> wrote:
>
> The LL TEMAC driver was updated to use the mac address from the board
> data,
> to use the Marvell specific PHY code so that 10 Mbit works, and to use
> the
> dcr_host from the platform data rather than using conditional
> compilation
> for DCR with DMA. The bootstrap loader was changed to read the mac
> address
> from the eeprom into the board data.
>=20
> Signed-off-by: John Linn <john.linn@xilinx.com>

This patch was badly wrapped by something ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Feb_2008_11_00_39_+1100_A_hV77=iTOJbe=DL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHxfmrTgG2atn1QN8RAubbAJoDurDfPCfxdgbTCTEez3aFNO/QcQCfYkJT
8bNYDenWtwkJldbFdm38ebI=
=ARrJ
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Feb_2008_11_00_39_+1100_A_hV77=iTOJbe=DL--

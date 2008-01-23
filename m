Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 46F03DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 13:47:16 +1100 (EST)
Date: Wed, 23 Jan 2008 13:46:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation for
	breaking out common code.
Message-Id: <20080123134654.cb5e249d.sfr@canb.auug.org.au>
In-Reply-To: <20080123020912.31675.48787.stgit@terra.home>
References: <20080123020912.31675.48787.stgit@terra.home>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_13_46_54_+1100_4VV2rh/jxS4l_yEV"
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_13_46_54_+1100_4VV2rh/jxS4l_yEV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Tue, 22 Jan 2008 21:09:12 -0500 Jon Smirl <jonsmirl@gmail.com> wrote:
>
> Rename i2c-mpc to i2c-mpc-drv in preparation for breaking out common code.
>=20
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
>=20
>  drivers/i2c/busses/Makefile      |    2=20
>  drivers/i2c/busses/i2c-mpc-drv.c |  421 ++++++++++++++++++++++++++++++++=
++++++
>  drivers/i2c/busses/i2c-mpc.c     |  421 --------------------------------=
------
>  3 files changed, 423 insertions(+), 421 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-mpc-drv.c
>  delete mode 100644 drivers/i2c/busses/i2c-mpc.c

Adding -M or -C to the "git diff" should identify renames and
makes this sort of patch much easier to review.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_13_46_54_+1100_4VV2rh/jxS4l_yEV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlqqjTgG2atn1QN8RAq0ZAKCK+QsH2QGCkrx+YDMK+3NGiOx69ACdHLGY
mZ61VkToH1dq/oWXudrnnRg=
=TE9k
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_13_46_54_+1100_4VV2rh/jxS4l_yEV--

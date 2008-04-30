Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5E19BDDEEE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:54:55 +1000 (EST)
Date: Thu, 1 May 2008 09:54:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH v4] sysdev,mv64x60: MV64x60 device bus
Message-Id: <20080501095448.7ddfffb3.sfr@canb.auug.org.au>
In-Reply-To: <1209574037.14407.57.camel@pcds-ts102.slac.stanford.edu>
References: <1209574037.14407.57.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__1_May_2008_09_54_48_+1000_jWT3/6/yiw6pJVX/"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__1_May_2008_09_54_48_+1000_jWT3/6/yiw6pJVX/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Remi,

On Wed, 30 Apr 2008 09:47:16 -0700 Remi Machet <rmachet@slac.stanford.edu> =
wrote:
>
> For each mv64360 entry in the OpenFirmware database, add the=20
> registration of an of_bus to take care of devices connected to
> the MV64x60 asynchronous devices controller.
> This change makes it possible for those devices to be detected by=20
> drivers that support the of_platform without having a custom call=20
> for each of them in the board file.
>=20
> Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)

You really should use '<' and '>' to surround your email address.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_May_2008_09_54_48_+1000_jWT3/6/yiw6pJVX/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGQbOTgG2atn1QN8RApszAJ4uvD7GKUCkJCRzLT7tyjWZYANQkQCfZAAc
HS4+T6/yvNadIf3LVu3Yp0o=
=STJb
-----END PGP SIGNATURE-----

--Signature=_Thu__1_May_2008_09_54_48_+1000_jWT3/6/yiw6pJVX/--

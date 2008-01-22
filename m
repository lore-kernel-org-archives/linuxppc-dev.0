Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CEF35DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:26:21 +1100 (EST)
Date: Wed, 23 Jan 2008 10:26:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH 2/2] MPC8641 HPCN: publish all soc and flash devices
Message-Id: <20080123102615.539388d0.sfr@canb.auug.org.au>
In-Reply-To: <1201020432.5716.159.camel@rhino>
References: <1201019917.5716.154.camel@rhino> <1201020432.5716.159.camel@rhino>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_10_26_15_+1100_ljF8Ci78E8M402uR"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_10_26_15_+1100_ljF8Ci78E8M402uR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wade,

On Tue, 22 Jan 2008 09:47:12 -0700 Wade Farnsworth <wfarnsworth@mvista.com>=
 wrote:
>
> +static struct of_device_id mpc86xx_ids[] =3D {

__initdata, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_10_26_15_+1100_ljF8Ci78E8M402uR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlnubTgG2atn1QN8RAnDAAKCIdMH6ZMy07Httkf7uaDM/M2/KCACcCb2o
v+zVM53j6EIObGPY7AXsf7o=
=pCXY
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_10_26_15_+1100_ljF8Ci78E8M402uR--

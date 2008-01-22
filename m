Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CDC98DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:28:05 +1100 (EST)
Date: Wed, 23 Jan 2008 10:28:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH v2 2/2] MPC8641 HPCN: call of_platform_bus_probe()
Message-Id: <20080123102800.409e146f.sfr@canb.auug.org.au>
In-Reply-To: <1201033065.5716.175.camel@rhino>
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
	<1201033065.5716.175.camel@rhino>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_10_28_00_+1100_YMTRk8oe1zU74Ekf"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_10_28_00_+1100_YMTRk8oe1zU74Ekf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2008 13:17:45 -0700 Wade Farnsworth <wfarnsworth@mvista.com>=
 wrote:
>
> +static struct of_device_id of_bus_ids[] =3D {

You forgot the __initdata.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_10_28_00_+1100_YMTRk8oe1zU74Ekf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlnwETgG2atn1QN8RAmMhAJ9oUfhlxsaajMJ/HxF0FsKKRFanQACfeEEe
5I1j+x4xw9RmNA6FZmHKVW4=
=bJVV
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_10_28_00_+1100_YMTRk8oe1zU74Ekf--

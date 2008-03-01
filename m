Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 05CA5DDE24
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 09:02:59 +1100 (EST)
Date: Sun, 2 Mar 2008 09:02:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2 v2] [OF] Add of_device_is_available function
Message-Id: <20080302090218.2c99976f.sfr@canb.auug.org.au>
In-Reply-To: <20080301081600.74598ce4@zod.rchland.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__2_Mar_2008_09_02_18_+1100_K+aStCt8c9DxhcJI"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__2_Mar_2008_09_02_18_+1100_K+aStCt8c9DxhcJI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sat, 1 Mar 2008 08:16:00 -0600 Josh Boyer <jwboyer@linux.vnet.ibm.com> w=
rote:
>
> IEEE 1275 defined a standard "status" property to indicate the
> operational status of a device.  The property has four possible values:
> okay, disabled, fail, fail-xxx.  The absence of this property means the
> operational status of the device is unknown or okay.
>=20
> This adds a function called of_device_is_available that checks the state
> of the status property of a device.  If the property is absent or set to
> either "okay" or "ok", it returns 1.  Otherwise it returns 0.
>=20
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Looks good to me - except the patch is word wrapped (which is weird for
Claws) ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__2_Mar_2008_09_02_18_+1100_K+aStCt8c9DxhcJI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHydJvTgG2atn1QN8RAqJ5AJ4+cfW9524cR7I2CnO0pPjW+p3nEgCfYYY0
dHszFmoUE3bfPj40MAmp7HY=
=azwT
-----END PGP SIGNATURE-----

--Signature=_Sun__2_Mar_2008_09_02_18_+1100_K+aStCt8c9DxhcJI--

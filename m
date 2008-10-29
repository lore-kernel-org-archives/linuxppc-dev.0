Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1511CDDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 23:13:08 +1100 (EST)
Subject: Re: [PATCH] uninorth agp: don't mark module parameter __devinit
From: Johannes Berg <johannes@sipsolutions.net>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1225282185.3546.376.camel@thor.sulgenrain.local>
	(sfid-20081029_130954_908818_BCA53077)
References: <1225246284.1369.31.camel@johannes.berg>
	<1225282185.3546.376.camel@thor.sulgenrain.local>
	(sfid-20081029_130954_908818_BCA53077)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rmY5DiQT9dBKTNalAMzd"
Date: Wed, 29 Oct 2008 13:12:59 +0100
Message-Id: <1225282379.5439.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rmY5DiQT9dBKTNalAMzd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-10-29 at 13:09 +0100, Michel D=C3=A4nzer wrote:
> On Wed, 2008-10-29 at 03:11 +0100, Johannes Berg wrote:
> > A module parameter can possibly be shown via sysfs, which isn't a good
> > idea if the section has been removed, so remove the __devinit
> > annotation.
>=20
> Under what circumstances could it be shown in sysfs?

Sorry, my mistake, I overlooked that it had 0 permission:
module_param(aperture, charp, 0);

otherwise it would of course be in sysfs.

Can uninorth_fetch_size be marked __devinit then?

johannes

--=-rmY5DiQT9dBKTNalAMzd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJCFNHAAoJEKVg1VMiehFYgRcP+wY7iAIu47wOivBh5HYyUx2s
S5FRNIgQ4Belt25BcibrGVDfyfiehRVkhK3WPVOFCzcloAKYTzCF+23Civ/lbYYu
PfC6pN59g8i4zy3PtbBHUnrZ0IRRCGxk3pRtZSY9GIIkVefdk40qKEIIN88xyHMN
furuk/aJFv4DvHGTxo2xqOLx1/Dfchkdp42OXM/j/KXd+z0T2rD5UHGDgdSc2KYK
07muiDYEHJ1vRG7dh1t7Ux7GveQUeQiTTi6RsDbqGW+ie7KXlzbIPJQUKL4NPyVi
VzC7+lttWZgr0G3nO9txXHtX6RygBxIos7w8M7mGusrh/s7wt0GUqKU3FuDlY4Yr
Am3J/XBs+qT+wAGOys2fLktRQhe3Jh8IfxrrO5dd5t4b9Gh6mFZgBvgbHUb2rwmB
KpWgFrNwaz2JchhqE4l5+ojMWs+bOIOo7QaDx4nBdeJ2ffcfJuVNptjut36zDvCU
nB7QScDQEghcuavn6EXPPIeR7wkvnVRaFfdTljuFySd2K1SgRJAl/LzBpQVp3Syw
oNMt77w4KlmoeFtuVi2LZtzNT1691qx+BZlpP2BaEHQOj8MoZqCMNa7bxbGS6khw
06QH5v2ln7e3zM4Cast3LcUaKH3oDNBjlbnB0WN2/AlOI904D6Z+qtiJSifajgkr
5KE2eYSQb116/bvmJ2oL
=E4b5
-----END PGP SIGNATURE-----

--=-rmY5DiQT9dBKTNalAMzd--

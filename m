Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 23FEADDF20
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:36:27 +1000 (EST)
Date: Thu, 23 Aug 2007 13:36:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: bogus vscsi dt node on iseries
Message-Id: <20070823133621.830245c4.sfr@canb.auug.org.au>
In-Reply-To: <20070822175121.GA21233@aepfle.de>
References: <20070822175121.GA21233@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Aug_2007_13_36_21_+1000_KNDsf45im6FEvllx"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Aug_2007_13_36_21_+1000_KNDsf45im6FEvllx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Aug 2007 19:51:21 +0200 Olaf Hering <olaf@aepfle.de> wrote:
>
>=20
> Does anyone know why dt_vdevices() creates a vscsi node on legacy iseries?
> I'm sure only viodasd and viocd is required as blockdevice type.

Because the IBM vscsi client (in theory) works on legacy iSeries.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Aug_2007_13_36_21_+1000_KNDsf45im6FEvllx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzQC5TgG2atn1QN8RAuU7AJ9EmJh6QzoMU/hUlAVOP5Eyz0/mCgCcCiUp
nhdDoghJoSSZ0si3m3CKnis=
=sz2c
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Aug_2007_13_36_21_+1000_KNDsf45im6FEvllx--

Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7CF8F67A01
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 11:39:28 +1100 (EST)
Date: Wed, 22 Mar 2006 11:39:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/11] powerpc: iseries: mf related cleanups
Message-Id: <20060322113908.3cb20dd7.sfr@canb.auug.org.au>
In-Reply-To: <20060321094632.ADC4467B6B@ozlabs.org>
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094632.ADC4467B6B@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__22_Mar_2006_11_39_08_+1100_3NSAqmwVH/BMxMry"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__22_Mar_2006_11_39_08_+1100_3NSAqmwVH/BMxMry
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Just some small nits ...

On Tue, 21 Mar 2006 20:46:02 +1100 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> +static int mf_initialized =3D 0;

We don't generally put the "=3D 0".

> +	mf_initialized =3D 1;
> +	mb();

Do we really need the mb().  If so, a comment saying why would be good.=20
(Yes, I know that you are just moving code.)

Otherwise looks good.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Mar_2006_11_39_08_+1100_3NSAqmwVH/BMxMry
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIJysFdBgD/zoJvwRAmG3AKCGqd079fNt32Kd/EsGaLcv1SKBlACdFYi1
mDvxiYfNCaffn5HPMdrsVGY=
=OQ+q
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Mar_2006_11_39_08_+1100_3NSAqmwVH/BMxMry--

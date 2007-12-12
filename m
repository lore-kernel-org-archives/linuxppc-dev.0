Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4B3DFDDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 15:45:35 +1100 (EST)
Date: Wed, 12 Dec 2007 15:45:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] wrapper: rename offset in offset_devp().
Message-Id: <20071212154528.7aaaa829.sfr@canb.auug.org.au>
In-Reply-To: <20071211212303.GA3661@loki.buserror.net>
References: <20071211212303.GA3661@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__12_Dec_2007_15_45_28_+1100_gpuvoD_R.BZ_3E7r"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Dec_2007_15_45_28_+1100_gpuvoD_R.BZ_3E7r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Dec 2007 15:23:04 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
>  #define offset_devp(off)	\
>  	({ \
> -		int offset =3D (off); \
> -		check_err(offset) ? NULL : (void *)(offset+1); \
> +		int _offset =3D (off); \
> +		check_err(_offset) ? NULL : (void *)(_offset+1); \
>  	})

Just wondering if this could be a static inline function?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__12_Dec_2007_15_45_28_+1100_gpuvoD_R.BZ_3E7r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHX2dtTgG2atn1QN8RAifqAJ91CajjWlkMLR7LFR2y+Ye6fm/R6gCfT/AZ
1uYsjR0fzRG4IxqvhCPdHIE=
=wVsD
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Dec_2007_15_45_28_+1100_gpuvoD_R.BZ_3E7r--

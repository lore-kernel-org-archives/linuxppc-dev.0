Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id CCFA32C00DB
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2012 16:30:06 +1100 (EST)
Date: Wed, 7 Nov 2012 16:30:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/pseries: Allow firmware features to match
 partial strings
Message-Id: <20121107163000.2d5c347e182ee8072eb78f7c@canb.auug.org.au>
In-Reply-To: <1352249356-29671-1-git-send-email-mikey@neuling.org>
References: <1352249356-29671-1-git-send-email-mikey@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__7_Nov_2012_16_30_00_+1100_tTd+rXSzW3E/3TXJ"
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__7_Nov_2012_16_30_00_+1100_tTd+rXSzW3E/3TXJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mikey,

On Wed,  7 Nov 2012 11:49:15 +1100 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> This allows firmware_features_table names to add a '*' at the end so that=
 only
> partial strings are matched.
>=20
> When a '*' is added, only upto the '*' is matched when setting firmware f=
eature
> bits.
>=20
> This is useful for the matching best energy feature.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> cc: Linux PPC dev <linuxppc-dev@ozlabs.org>

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__7_Nov_2012_16_30_00_+1100_tTd+rXSzW3E/3TXJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQmfHYAAoJEECxmPOUX5FEgdQP/0FzmDTyNV1lrvaQKixz/nq7
HJja0rcAliDq8glxouk9R0cY+oc/loceyI81phraaN3AEq/3+iFxY/5fE5EPYuUu
m2+KIwdsZEDGMgSMBk5A6CJUA9OggtMeitu4PWP1K6zco3fbZRABdtjtVDbNUlZ2
JVpcnuq10PiIEIyV7XPo9ZR0jzxvBZXFJXNKKHSyIk040Y2kdxnhFn7Txc//i/7e
7dGcv+QvvHBVJYm39GdfMpr2ZarN3Fos9yKmhZF+MxCu/A/YH+lXHv7UPX4X5UYR
Mpxf37odccHwYS7BSWxAOgpAGhv/Y5LEerL4Adx21i95zz5C2JCPfgasb4tBkbrl
5+RbMX8RXd9KT6evE0dpl1llWQEEzUrM2ijdcNu182bt4FpJqlk4T3zCgMyLpd+E
562CBRHiAhgbKG40muqDN7+V9RL8uFu6RrYgMmqof2d/Dv7GjeQ5y7GR3zsnHLFa
HGuDDMUE6D8NXc0tICaIsdLe6nn/hJ3Dfns1aBG9F4J3IG0ItAVCpg4mcQvraAve
HJN8fkiQSzMJzjp7YJQrNnEGjMkRlyBOoGVo7k5Nb4P5lz2/fMcnc0VYQDZZIZkW
/dT/8Ys/402SbHJgK9Vw4mb8nh3zzcykfy8Bvmlrj2byhYheuos4GWdr7SEvOO7f
YeoO4h6WbsnAGj0dkSGY
=+hiZ
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Nov_2012_16_30_00_+1100_tTd+rXSzW3E/3TXJ--

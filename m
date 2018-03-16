Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gj054KBzF08D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 20:51:48 +1100 (AEDT)
Date: Fri, 16 Mar 2018 20:50:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: build warning in drivers/macintosh/rack-meter.c
Message-ID: <20180316205044.098aebd3@canb.auug.org.au>
In-Reply-To: <20180316093747.dxle5xhwwi2nptqz@darkstar.musicnaut.iki.fi>
References: <20180316164614.07f2f573@canb.auug.org.au>
 <20180316093747.dxle5xhwwi2nptqz@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3TwNjqU.2vIlJxUQxtEtERH"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/3TwNjqU.2vIlJxUQxtEtERH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Aaro,

On Fri, 16 Mar 2018 11:37:47 +0200 Aaro Koskinen <aaro.koskinen@iki.fi> wro=
te:
>
> I can send a fix for this and test on Xserve.

Excellent.  (I should send emails about more old warnings :-))

--=20
Cheers,
Stephen Rothwell

--Sig_/3TwNjqU.2vIlJxUQxtEtERH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqrk3QACgkQAVBC80lX
0GwRTQf+LZ5vx5GJhRzBt2MZlRMsrVZ1ZhsESOoKy+IQ/cxRHk2HlupVdsnc71NS
8ILil3iN3ce5hMN5DMJGfp0UoEhrKn39Zsgpgb5z/Nyt6/ouKuEA3gn+p6JWRZ2i
v0pewA0gnZxzT42axyNL5FzI3yHJ9b2t8OIEzxZayrK+k/MEuRFL4VTLpxUyNT/7
RSWbloVx1Oarjky6lGA1Y6TpE1jWhqStRDsb5Jssd6GHu9aMLGC21ervNtHpRkEN
Z+0uDujIOhxNyQCdzSo4FhiLgvF6gpkL1RYX0LygH6k6Wih9vYDMwXDbAl5qGVMo
7tOltMdB+7rMHcBafCV9GDx3YEW+yw==
=dyPC
-----END PGP SIGNATURE-----

--Sig_/3TwNjqU.2vIlJxUQxtEtERH--

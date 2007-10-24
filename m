Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 08944DDEF7
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 17:11:38 +1000 (EST)
Date: Wed, 24 Oct 2007 17:11:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to common
	show_cpuinfo()
Message-Id: <20071024171129.3ad06712.sfr@canb.auug.org.au>
In-Reply-To: <20071023231309.29359.20887.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231309.29359.20887.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__24_Oct_2007_17_11_29_+1000_Y62_Jy3FEi9oslbA"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__24_Oct_2007_17_11_29_+1000_Y62_Jy3FEi9oslbA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Oct 2007 01:13:09 +0200 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +		root =3D of_find_node_by_path("/");
> +		if (root)
> +			model =3D of_get_property(root, "model", NULL);
> +		of_node_put(root);

The paranoid part of me says:

		if (model)

> +		seq_printf(m, "machine\t\t: %s\n", model);

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__24_Oct_2007_17_11_29_+1000_Y62_Jy3FEi9oslbA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHvAmTgG2atn1QN8RAplbAJ0epwUfwJjCl9bC+eKBmm/p9HX+AwCbB0rO
+R5qLuH6UUztH0fS9H3YBas=
=fSvR
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Oct_2007_17_11_29_+1000_Y62_Jy3FEi9oslbA--

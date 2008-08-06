Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 43672DE207
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 17:50:33 +1000 (EST)
Date: Wed, 6 Aug 2008 17:50:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 5/6] powerpc: add USB peripheral support to MPC836xMDS
Message-Id: <20080806175026.82797918.sfr@canb.auug.org.au>
In-Reply-To: <1218006285-27138-5-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Aug_2008_17_50_26_+1000_BlpH/lFvlieOB2D9"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Aug_2008_17_50_26_+1000_BlpH/lFvlieOB2D9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Li,

On Wed,  6 Aug 2008 15:04:44 +0800 Li Yang <leoli@freescale.com> wrote:
>
> @@ -93,6 +93,12 @@ static void __init mpc836x_mds_setup_arch(void)
> =20
>  		for (np =3D NULL; (np =3D of_find_node_by_name(np, "ucc")) !=3D NULL;)
>  			par_io_of_config(np);
> +
> +		np =3D of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
> +		if (np) {
> +			par_io_of_config(np);
> +			qe_usb_clock_set(np);

			of_node_put(np);

> +		}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_17_50_26_+1000_BlpH/lFvlieOB2D9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZV8IACgkQjjKRsyhoI8wSwACfR0OiMaotJbtyOo4fHc84SFBf
vWgAniNnTDvYQnNFC2TL4vs7ZORuKCYW
=rDek
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_17_50_26_+1000_BlpH/lFvlieOB2D9--

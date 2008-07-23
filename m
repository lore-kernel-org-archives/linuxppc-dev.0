Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0172FDDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 15:30:22 +1000 (EST)
Date: Wed, 23 Jul 2008 15:30:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver with soc-of-simple
Message-Id: <20080723153017.1b235313.sfr@canb.auug.org.au>
In-Reply-To: <20080722235351.11648.56387.stgit@terra>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN"
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Tue, 22 Jul 2008 19:53:51 -0400 Jon Smirl <jonsmirl@gmail.com> wrote:
>
> +static struct snd_soc_ops *machine_ops =3D NULL;
> +static char *machine_name =3D NULL;

You don't need these initialisations.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiGwekACgkQjjKRsyhoI8yRywCfeVwTrAHd2MVL1QWc/2EAm3xs
FykAn0hTPK6uXBcW3Nt9U3/+zQGBwMk4
=nIzX
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN--

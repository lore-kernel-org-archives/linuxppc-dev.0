Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 7 Mar 2008 11:31:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip DMA
	engine
Message-Id: <20080307113150.c0874344.sfr@canb.auug.org.au>
In-Reply-To: <20080306233900.GA3969@lixom.net>
References: <20080306233900.GA3969@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__7_Mar_2008_11_31_50_+1100_oaTFoPpUPFtrVWSm"
Cc: hskinnemoen@atmel.com, shannon.nelson@intel.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	pasemi-linux@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__7_Mar_2008_11_31_50_+1100_oaTFoPpUPFtrVWSm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

Just one thing I noticed ...

On Thu, 6 Mar 2008 17:39:00 -0600 Olof Johansson <olof@lixom.net> wrote:
>
> +	dma_dev->device_dependency_added =3D pasemi_dma_dependency_added;

device_dependency_added is going away in 2.6.26 ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__7_Mar_2008_11_31_50_+1100_oaTFoPpUPFtrVWSm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH0Iz6TgG2atn1QN8RAnm9AJ9Untb2ftwcbu9xkD/9HSVkAaFfPQCfemLP
gWkqeNeF4p/QbQk/X9Bh6n0=
=CBww
-----END PGP SIGNATURE-----

--Signature=_Fri__7_Mar_2008_11_31_50_+1100_oaTFoPpUPFtrVWSm--

Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 3 May 2007 12:03:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 8/13] powerpc: Add arch/powerpc mv64x60_eth platform
	data setup
Message-Id: <20070503120310.7b55c6a6.sfr@canb.auug.org.au>
In-Reply-To: <20070502214312.GC27253@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000009.GJ4046@mag.az.mvista.com>
	<20070502214312.GC27253@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_May_2007_12_03_10_+1000_hwc2RZWw7P343kF0"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2007_12_03_10_+1000_hwc2RZWw7P343kF0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 2 May 2007 14:43:12 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
>
> +	const void *prop;

Since all uses of this are being cast to "int *" before being
dereferenced, maybe you should declare it as a "const int *".

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_May_2007_12_03_10_+1000_hwc2RZWw7P343kF0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGOULiFdBgD/zoJvwRAtBiAJ4+oK6lc78DOVkXWwWiqJAkWIEA7QCffbxV
YEmGlcHckIk93ixx1yTyySk=
=6TSS
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2007_12_03_10_+1000_hwc2RZWw7P343kF0--

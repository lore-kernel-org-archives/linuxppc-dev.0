Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CED51B6FBC
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2012 03:45:54 +1100 (EST)
Date: Mon, 19 Mar 2012 16:37:42 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v3] powerpc/8xxx: remove 85xx/86xx restrictions from
 fsl_guts.h
Message-ID: <20120319163742.GE5132@opensource.wolfsonmicro.com>
References: <1332173199-25877-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
In-Reply-To: <1332173199-25877-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 11:06:39AM -0500, Timur Tabi wrote:
> Remove the check for CONFIG_PPC_85xx and CONFIG_PPC_86xx from fsl_guts.h.
> The check was originally intended to allow the same header file to
> be used on 85xx and 86xx systems, even though the Global Utilities
> register could be different.  It turns out that they're not actually
> different, and so the check is not necessary.  In addition, neither
> macro is defined for 64-bit e5500 kernels, so that causes a build
> break.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ2DPAAoJEBus8iNuMP3dai8P/1ww1tYX9L6JQlzxQL7ULSHS
Y6vjfzMENU1zTMNkXOSlX+vhC93BSpBmhiBkR5stlTaYwwzuxH/L+b8+RuY3Q70g
3ZcK5b2roTmB2sWvdcXzIbP59uw9Njo1u5Huit1YDCsrU/Z/cFk9vDXcLDgLuXyF
4T3fyzBXv5TwlKB5g+0kGd+RE1RDw0e4Jmk0c335NvdLz/aG9sEpb6J109Ze3xBf
BApOXSTpUimvw69P4q32aapE3fmaahtD86eT1fosmJGbUCI9jNVTsovIOECzhigX
w6ttTooXnoaz2SWScqliL4EWhimb5s0cVLJ3NXRkpcfQGFXXxmQoO8MEv7I72KHH
6fyXH0JNfoyUjpJfuskHt+/o/JLXcBbFZGy6o7UKqHx6VmEunW6AyXsdQeptVZ/d
dCjHNvWlh2ZGqQj4l2/w/s+q8M6186nVHhWsWNO4Fsaf2JeGJPpAm1w7XW+ccp3Q
aHS4KGjH6FrRTCusuQfuAjFLFyfNSbMkZyWVrBc37u2++wUGhVSrPIm+UO8w2Mto
i7XFbNHv/9Szh5KEjwCFmMMSCZi5qqZ1LBBsfqT3IW5zTUNE02v4Z/vAfHsJlBCa
2NOH0dpT+K4g5/a1HHBJgloUNl0xM3s7C8Y5GPwfuWcJCVim+oH0KQPAz/8rVlFu
PlBCZH6/8WgleS7qRRbp
=+kSB
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

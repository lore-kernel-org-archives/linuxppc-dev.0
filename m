Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D45522C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 23:29:00 +1000 (EST)
Date: Wed, 31 Jul 2013 14:28:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20130731132849.GR9858@sirena.org.uk>
References: <cover.1375271745.git.b42378@freescale.com>
 <ad8f9d8812c1823ae6f9e4a0d1e6d3c76b26a285.1375271745.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6R6uZ1KJeew1pu/D"
In-Reply-To: <ad8f9d8812c1823ae6f9e4a0d1e6d3c76b26a285.1375271745.git.b42378@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: codec: spdif: Add S20_3LE and S24_LE support
 for dummy codec drivers
Cc: devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6R6uZ1KJeew1pu/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 08:07:05PM +0800, Nicolin Chen wrote:
> Generally, S/PDIF supports 20bit and optional 24bit samples. Thus add these
> two formats for the dummy codec drivers.

Applied, thanks.  Please check the mailing lists you're posting to -
you've got the DT list wrong here and you shouldn't post non-binding
reviews there anyway.

--6R6uZ1KJeew1pu/D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+REOAAoJELSic+t+oim9MNgQAJsRCS7pizBIQ9QClY8auT3L
VvimYRxFA3PvpfUmRVHfv+a+RmWIftPRLQzWGIjoxjgs9CZzybEqP/cWRmiGSFWO
jsoFnqs+JjXfd6nLRDLgI36POP7gRFTT3+lHAcmdWeG/mxRpDTphlLKQhEL7MHvA
JyFSLL4N8p2jgy7Owg/7ayM4e9EDEMOPjB6Zc6bn4FZiGoiP3Feu60V81fdd3qiA
UphTSDPd+rgq599yyyFqYKIKdtqKCOATU1zhcO/fhamSkrJc11PM3wnJ2cYXqRvA
y9qQ31NJc8e/pjJJUCubaiYtCx6pxD21vY6BJdqW0itnc+Vbd0Xu8Dky4r8iTNY+
DnGSaA8Gr1Ufjms9JJaBKqen+cvY5A1ijkOte19OnHLZ5XmiLCei7r3wNaRnP+5k
qvHSy1anpz8dg+WvM52p4I8OcHZ8+dY9R7YS/AnHHwl734MUZEG+ewHH0wVK2xWm
HXXiKphZ0/xayo6/L6xL/fVOaz7aLC5N2swUHG0WauIBwIBrZSyJsTG4iV3zTfAt
joAH6l5WeL14Gpad90y1w5mbzRleQdAJb+rwY3oUJ0Ho/CgeYolu0zmjCCeZICs2
mbXRLE2fzrnvU2MGvX+ZuENl5c2b8nKNBMkXFOmyY4wZL9U8K/NRbEHDom97P/yd
tCkao/P5zLmWen4susBa
=6vr8
-----END PGP SIGNATURE-----

--6R6uZ1KJeew1pu/D--

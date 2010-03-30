Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCFCBB7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 11:09:49 +1100 (EST)
Date: Tue, 30 Mar 2010 02:09:41 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
Message-ID: <20100330000941.GA14322@pengutronix.de>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather>
	<20100326221707.GA1953@leila.ping.de>
	<20100326225916.GA5690@feather>
	<20100327174455.1888CEAD184@gemini.denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
In-Reply-To: <20100327174455.1888CEAD184@gemini.denx.de>
Cc: Wolfgang Wegner <wolfgang@leila.ping.de>, linuxppc-dev@lists.ozlabs.org,
	Josh Triplett <josh@joshtriplett.org>,
	Andrew Greenberg <andrew@psas.pdx.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> We tested CF cards for DMA support some time ago, and IIRC this
> included the STK5200. Situation was that only very few CF cards
> actually support DMA (even if they advertise it on the label).

Huh, not nice. Were those consumer cards or also industrial grade cards? Ma=
ybe
that is the reason? With the latter, I have never seen this, they always to=
ld
the truth, so far. Although we mostly used MWDMA, no UDMA to avoid the
hardware problems.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuxQUUACgkQD27XaX1/VRtmIQCfUPGkuvWnnXT4CkYSol/58/PA
YnQAoKxC67FQ80kx0cODKvHlq2GElz8/
=lzF5
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

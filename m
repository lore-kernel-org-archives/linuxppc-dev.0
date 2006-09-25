Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7223667BF8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 03:41:08 +1000 (EST)
Date: Mon, 25 Sep 2006 19:41:01 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060925174101.GC21204@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
	<20060921160808.GB4828@igloo.df.lth.se>
	<1159202991.5485.0.camel@localhost>
	<20060925171754.GB21204@igloo.df.lth.se>
	<1159204851.5485.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
In-Reply-To: <1159204851.5485.6.camel@localhost>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 25 Sep 19:20 CEST 2006, Matthew McClintock wrote:

> #ifdef OF_STDOUT_PATH
>         ft_prop_str(&cxt, "linux,stdout-path", OF_STDOUT_PATH);
> #endif

Great! I had missed those lines (while manually applying your patches to
my own modified U-Boot 1.1.4 sources) ...

Now I'm back to the state of last Thursday (except for getting rid of
the unnecessary chosen node and getting bootargs passed nicely), which
means that the serial console initially works, but stops working after
the call to console_init() in start_kernel().

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRRgUrcRKuLhQMn35AQK/nwP+K+p0vj+ZIJ4jmVGTP2+S0TuJmVPYwf4B
lSOIh2ZU9R29SYu6U0Ob6u2NZgRTrui/xf5WLn2C+sPqO5Qco218otn568cWHRen
99R403EC4Oj/Qy9fHTnxS9reAFlA88Mbsi+Qu+G/72IrWgJJ89NgKb0n60E3nLug
L7clB32MYZ0=
=A9CY
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

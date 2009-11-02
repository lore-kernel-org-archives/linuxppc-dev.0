Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4A252B7C28
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 10:10:39 +1100 (EST)
Date: Tue, 3 Nov 2009 10:10:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2] mpc512x/clock: fix clk_get logic
Message-Id: <20091103101032.496a0290.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40911020948o673b058emba4bb2ccfc1cfd17@mail.gmail.com>
References: <20091030105414.GD717@sirena.org.uk>
	<1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40911020948o673b058emba4bb2ccfc1cfd17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Nov_2009_10_10_32_+1100_y/08cLERD3yBLUYq"
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <roel.kluin@gmail.com>,
	Wolfgang Denk <wd@denx.de>, Mark Brown <broonie@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Nov_2009_10_10_32_+1100_y/08cLERD3yBLUYq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Mon, 2 Nov 2009 10:48:58 -0700 Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
> Using bool/true/false doesn't seem to be a common pattern in the
> kernel.  Anyone know what the winds of prevailing opinion are
> regarding 'bool' in kernel code?

Its a good thing.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Nov_2009_10_10_32_+1100_y/08cLERD3yBLUYq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrvZugACgkQjjKRsyhoI8xfawCgpkvWf+u8/V8T5p5mhFYWGTka
/5UAn09rkkx+E/6dBQLass9uWhhJYeBk
=rKnD
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Nov_2009_10_10_32_+1100_y/08cLERD3yBLUYq--

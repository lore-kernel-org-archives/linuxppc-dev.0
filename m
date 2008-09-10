Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F3BDEDDF48
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 00:50:20 +1000 (EST)
Date: Thu, 11 Sep 2008 00:50:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] fix compile failure with non modular builds
Message-Id: <20080911005005.80a12d5d.sfr@canb.auug.org.au>
In-Reply-To: <1221007599.14835.16.camel@pasglop>
References: <1221005058.23271.16.camel@localhost.localdomain>
	<1221005387.14835.14.camel@pasglop>
	<1221005505.23271.18.camel@localhost.localdomain>
	<1221007599.14835.16.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Sep_2008_00_50_05_+1000_e33nS5mgn4eLEnnG"
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Sep_2008_00_50_05_+1000_e33nS5mgn4eLEnnG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2008 10:46:39 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> I must admit that none of my test configs I think has module support
> turned off (even if I tend to have all the stuff I need built-in).

And our allnoconfig turns off CONFIG_64BIT, so we didn't see it in any of
our automated builds.  :-(

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Sep_2008_00_50_05_+1000_e33nS5mgn4eLEnnG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjH3p0ACgkQjjKRsyhoI8y7bQCfVaalknSSIrgXHW3VTJUByUlc
yZUAoLx1m4aO8wU1FXPQ1TdqUhaY494y
=SCUK
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Sep_2008_00_50_05_+1000_e33nS5mgn4eLEnnG--

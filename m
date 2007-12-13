Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BA624DDF62
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 11:56:09 +1100 (EST)
Date: Thu, 13 Dec 2007 11:55:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-Id: <20071213115553.8c0d2980.sfr@canb.auug.org.au>
In-Reply-To: <47606538.2090605@freescale.com>
References: <20071211212247.GB3620@loki.buserror.net>
	<20071212154306.dee76c80.sfr@canb.auug.org.au>
	<47606538.2090605@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__13_Dec_2007_11_55_53_+1100_X2S_87kV2Ag2C9Ei"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__13_Dec_2007_11_55_53_+1100_X2S_87kV2Ag2C9Ei
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Dec 2007 16:48:24 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> Stephen Rothwell wrote:
> >> +	ep8248e_bcsr =3D of_iomap(ep8248e_bcsr_node, 0);
> >=20
> > of_node_put(ep8248e_bcsr_node;
>=20
> No, because we hold on to the node for later use in ep8248e_mdio_probe().

Sorry, you are right, I didn't notice that it was global ...

> BTW, is there any actual node removal done that justifies dealing with=20
> refcounts everywhere?

In the hotplug code.  So I guess it is not very relevant to you, but it
is a pain to retrofit this stuff if it does become important more widely.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__13_Dec_2007_11_55_53_+1100_X2S_87kV2Ag2C9Ei
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHYIMdTgG2atn1QN8RAnFlAKCECX9gsfWeF5JDFLuE2GE6VMM8hACgiGLN
woppBlSxUCGBrec3roajtIg=
=DQG6
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Dec_2007_11_55_53_+1100_X2S_87kV2Ag2C9Ei--

Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 54D74DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 18:36:42 +1100 (EST)
Date: Tue, 18 Mar 2008 18:33:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
Message-Id: <20080318183320.49c98183.sfr@canb.auug.org.au>
In-Reply-To: <47DF6B82.4030404@denx.de>
References: <47DA444E.9050507@denx.de>
	<20080315102508.bc698a90.sfr@canb.auug.org.au>
	<47DF6B82.4030404@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__18_Mar_2008_18_33_20_+1100_cTEkSecc.+i0uaRc"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__18_Mar_2008_18_33_20_+1100_cTEkSecc.+i0uaRc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Tue, 18 Mar 2008 08:13:06 +0100 Heiko Schocher <hs@denx.de> wrote:
>
> Stephen Rothwell wrote:
> > On Fri, 14 Mar 2008 10:24:30 +0100 Heiko Schocher <hs@denx.de> wrote:
> [...]
> >> +struct cpm_pin {
> >> +		int port, pin, flags;
> >> +};
> >=20
> > I wish someone would consolidate all these definitions of cpm_pin.
>=20
> Hmm... do you mean something like, moving this struct
> in cpm1.h and ...

Yes or somewhere else appropriate.

> >> +	for (i =3D 0; i < ARRAY_SIZE(mgsuvd_pins); i++) {
> >> +		struct cpm_pin *pin =3D &mgsuvd_pins[i];
> >> +		cpm1_set_pin(pin->port, pin->pin, pin->flags);
> >> +	}
> >=20
> > And the code that uses them ...
>=20
> making in arch/powerpc/sysdev/cpm1.c a function
> cpm1_setup_pins (struct cpm_pin *pins) ?

Yes.

This is not necessary for your patch, but would be a nice cleanup later.
N.B. this struct is alos used by users of cpm2_set_pin().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__18_Mar_2008_18_33_20_+1100_cTEkSecc.+i0uaRc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH33BETgG2atn1QN8RAiNlAKCSNtHYiJSW6TTr7alO3u0YbellhACggyfH
jAfMGIxobW8O+CF5f4mGmpM=
=/KBY
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Mar_2008_18_33_20_+1100_cTEkSecc.+i0uaRc--

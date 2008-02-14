Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2A123DDE2F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:27:12 +1100 (EST)
Date: Fri, 15 Feb 2008 10:27:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Enable correct operation of serial ports
	withnonzero regshift.
Message-Id: <20080215102706.1b7c30c1.sfr@canb.auug.org.au>
In-Reply-To: <20080214185534.81F625F808D@mail186-dub.bigfish.com>
References: <47B35ED8.7020404@ru.mvista.com>
	<20080214185534.81F625F808D@mail186-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__15_Feb_2008_10_27_06_+1100_5kHI9+OPPbPgiTVi"
Cc: linuxppc-dev@ozlabs.org, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__15_Feb_2008_10_27_06_+1100_5kHI9+OPPbPgiTVi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Feb 2008 10:55:31 -0800 "Stephen Neuendorffer" <stephen.neuendor=
ffer@xilinx.com> wrote:
>
> > --- a/arch/powerpc/kernel/legacy_serial.c
> > +++ b/arch/powerpc/kernel/legacy_serial.c
> > +	/* get regshift if present*/
> > +	regshift =3D get_property(np, "reg-shift", NULL);
>=20
> of_get_property, presumably?

Damn, how did I miss that?  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__15_Feb_2008_10_27_06_+1100_5kHI9+OPPbPgiTVi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHtM5PTgG2atn1QN8RAkQ3AJ9iHS2hYigQMSZxssI03/6s8NiJEQCgmvZ8
sb3bhVCzdcMGZ8fDB6CX7qY=
=Dpps
-----END PGP SIGNATURE-----

--Signature=_Fri__15_Feb_2008_10_27_06_+1100_5kHI9+OPPbPgiTVi--

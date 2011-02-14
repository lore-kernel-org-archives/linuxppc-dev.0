Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0A0CFB7194
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 22:34:37 +1100 (EST)
Date: Mon, 14 Feb 2011 14:34:19 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	InterfaceLayer
Message-ID: <20110214143419.0da18a20@apollo.gnet>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC4D@saturn3.aculab.com>
References: <4f99d54a42d4f13663c88b0b081f047b@mail.gmail.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC4D@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/WhrkfhfnR9tZ21A6h3mH1x=";
	protocol="application/pgp-signature"
Cc: Tirumala Marri <tmarri@apm.com>, Greg KH <greg@kroah.com>,
	linux-usb@vger.kernel.org, Mark
	Miesfeld <mmiesfeld@apm.com>, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/WhrkfhfnR9tZ21A6h3mH1x=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Mon, 14 Feb 2011 08:53:21 -0000
"David Laight" <David.Laight@ACULAB.COM> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> =20
> > > Sorry, I don't understand that. I think u32 is always 32bit=20
> > > 4byte on all archs. Right?
> >=20
> > Yes.
> >=20
> > Use an unsigned long if you want to hold a pointer correctly on all
> > arches.
>=20
> Although that is true for many systems (and probably all ppc Linux)
> it isn't necessarily true (eg 64 bit Microsoft Windows).
> C99 inttypes.h should define uintptr_t as an unsigned integer
> type that is large enough to hold a (data) pointer.
> I'm not sure if this is defined for the Linux kernel.

I think, the most reasonable option is to use a pointer type to hold
pointer. :)

--=20
  Alexander

--Sig_/WhrkfhfnR9tZ21A6h3mH1x=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNWRM7AAoJEElrwznyooJbDFwH/R8U/7xN8E0f/fZu6Qknvnyl
qUvab2dcJnoFNSDGZxZGXLiQd+6b8qDLa/ioWduRzEzRtAcby3yueJ8wbsbireL6
gyKGsEDHw78d65oc8NOg/nJk3ugXXRnsL8VnD/UP8iZ1pNEk0nSo6wuMbEsFZMJu
ytjbqHKb9yZ/TYfPajmvRrOlhNGjYJIXfhixNOhyTJPfzynD+oMOJ4viZhR/E/tR
nAha5OIegsFoAnrOKNqUQytC/rdyRNbINS0aSSGlTM+apf4SRYtdoMQ3FHj9vCgt
mpuHBT7btHl9MNNooT0dUR4wuu6iirXZQkIhxQp4doinxH3R0U0A5qeukkSNisE=
=xavO
-----END PGP SIGNATURE-----

--Sig_/WhrkfhfnR9tZ21A6h3mH1x=--

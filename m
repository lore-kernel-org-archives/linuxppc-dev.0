Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 07B191007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 18:10:35 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 24C72C00E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 08:06:04 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
Date: Tue, 12 Jan 2010 08:06:03 +0100
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220759.23453.roman.fietze@telemotive.de>
	<fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
In-Reply-To: <fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201001120806.03728.roman.fietze@telemotive.de>
Content-Type: multipart/signed; boundary="nextPart1299990.2WCzgrOAB3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1299990.2WCzgrOAB3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Grant,

On Monday 11 January 2010 20:15:58 Grant Likely wrote:

> No patch description?  Very few patches are sufficiently described by
> the subject line alone.  Tell me what the problem is, what the patch
> changes, and why.

And a lot of other information. Thank you very much for the effort you
put into those patches. I almost knew that you will criticize e.g.
patches that mix functional and "optical" changes, patches that are
not describing more exactly what I did.

As soon as I have some time left I will try to go once more from the
original driver to the final driver using clear and separate, well
bescribed patches, of course taking care of your and other people
comments.

Again, thanks


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

Amtsgericht Ulm                                HRB 541321
Vorstand:
Peter Kersten, Markus Fischer, Franz Diller, Markus Stolz

--nextPart1299990.2WCzgrOAB3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAktMH1sACgkQp5XY/BK//MLbPwCfWE8j6CKNwlu92qgq+/+6tDSa
+owAn0XioBoMAxCQbHN8uXJlZ0usWASb
=Vxbm
-----END PGP SIGNATURE-----

--nextPart1299990.2WCzgrOAB3--

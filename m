Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 033DA1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 18:56:03 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 03/13] mpc52xx: add SCLPC register bit definitions
Date: Tue, 12 Jan 2010 08:55:58 +0100
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220800.54373.roman.fietze@telemotive.de>
	<fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
In-Reply-To: <fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201001120855.59122.roman.fietze@telemotive.de>
Content-Type: multipart/signed; boundary="nextPart3798798.cbk5vydfiR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart3798798.cbk5vydfiR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Grant,

On Monday 11 January 2010 20:21:22 Grant Likely wrote:

> Unrelated whitespace change?

My fault, as with some other white space changes. My Emacs is
configured using some older setup found in a 2.4
Documentation/CodingStyle. Before saving a file my spine is used to
reformat the whole source file, which then causes those artefacts.
I'll fix the Emacs setup and try to fix my spine, and double check
before commits.

BTW: no Emacs users amongst the kernel coders any more? At least I
have to read "So, you can either get rid of GNU emacs, or ...".


> I prefer the (1<<n) style myself.

Ok. Looking at it a second time you and Wolfgang are definitively
right. And I prefer the (1<<n) style a lot more than the 0x0080 style.


> Why is the list head being removed?

Not used at all, except in initialization?

Of course a seperate patch would have been needed.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

Amtsgericht Ulm                                HRB 541321
Vorstand:
Peter Kersten, Markus Fischer, Franz Diller, Markus Stolz

--nextPart3798798.cbk5vydfiR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAktMKw8ACgkQp5XY/BK//MKbHQCfX3aufw0LCkf8LcV4XFB6rb+O
I0IAnjRH0WVXAAai9bEI5uaCtlmBZtV3
=/y3t
-----END PGP SIGNATURE-----

--nextPart3798798.cbk5vydfiR--

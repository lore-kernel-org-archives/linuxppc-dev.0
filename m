Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30CBD1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 14:43:27 +1000 (AEST)
Received: by pdbqm3 with SMTP id qm3so14317938pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2015 21:43:24 -0700 (PDT)
Message-ID: <1436416901.28537.11.camel@axtens.net>
Subject: Re: [PATCH v2] powerpc/powernv: Fix race in updating core_idle_state
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 09 Jul 2015 14:41:41 +1000
In-Reply-To: <1436228558.3341.1.camel@ellerman.id.au>
References: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1436228558.3341.1.camel@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-sfJ3uKvKRdcs5Ijr76zn"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-sfJ3uKvKRdcs5Ijr76zn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I recommend creating an alias or script that does:
>=20
> $ git log --pretty=3Dfixes -n 1 $commit | xclip
>=20

FWIW, having finally got around to doing this, I found I first needed
the following snippet in ~/.gitconfig from
https://www.kernel.org/doc/Documentation/SubmittingPatches


	[core]
		abbrev =3D 12
	[pretty]
		fixes =3D Fixes: %h (\"%s\")

Otherwise git doesn't know what the pretty format is.

--=20
Regards,
Daniel

--=-sfJ3uKvKRdcs5Ijr76zn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVnfuPAAoJEPC3R3P2I92F9NcQAJrv/9h/9twLqgPcGzkkScR4
Jm2xUydBAJtZH9FqLdqULOZuShtNQ/XQ630nRCsi6tEiJXQcVC4gqW+2C45pYRio
Yc3dTGj+ZuAd9mCE9RlFTmZROm4aG+HZvtltWr1erg4cLF58OfwQaFaQrP0U7Gxq
+eH8mxMe6e6KaDto16tWAXllwObm0Ri6nnBd0m1L/QZHQw0rrDeCafcCWq6TjCXk
U6gvfj5Ox/57K1SG4IK1LRDDYR2qiFfInWm9p231OsvMf/yfEI2WovMg8q0tX6gJ
6C/8ycx7EUpGjkKYysEionBI7MEryGJ8q4vpsDhmau5mO8ALk3sTIilSFfWSha7i
xWU3NVwuruxq3K1LtQKrutUaV5WwAP9bUYkoXqorPxLK7k/YuHhFBlTGMwgUUGq0
dwqxCRhR3LJzf7sOvjgmrjlCFSZR1XRx/z7Kr0P1aidkxeiE5uJkuH6lLeMXgwx4
wCen4L1TnVmjE4Lc1y3OaEvLAsiNXRhJm2lt4EscALN/AO0BYkcWblM7t7MKLPTE
8R7Bzd2JpPycrmUvR24X/PPhCm+kXgRVO123gWjzEsIzXbbaejZT4gOJ687iPZN3
LoJ7oqR9UvP01AwPUbRvx+siu8UlF5lt1D4JIy3tjoFQ28Qi4XL0nreIHme2lWsJ
MbB7Au2GbHASaGJAQPQv
=ErFU
-----END PGP SIGNATURE-----

--=-sfJ3uKvKRdcs5Ijr76zn--

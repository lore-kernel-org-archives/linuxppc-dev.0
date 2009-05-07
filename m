Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6B07ADDF7E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 09:16:55 +1000 (EST)
Date: Fri, 8 May 2009 09:16:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: Re: [PATCH] powerpc/iseries; fix pci breakage
Message-Id: <20090508091643.ca44575c.sfr@canb.auug.org.au>
In-Reply-To: <20090507100752.4fa4db7f.sfr@canb.auug.org.au>
References: <20090507100752.4fa4db7f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__8_May_2009_09_16_43_+1000_k9TYUvOiYIVpKda="
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Becky Bruce <becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__8_May_2009_09_16_43_+1000_k9TYUvOiYIVpKda=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 7 May 2009 10:07:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> This is a regression in v2.6.29 from v2.6.28, so I guess we need to
> send this to the stable team (backported if necessary) after it is upstre=
am.

This same patch applies to 2.6.29.2 and fixes the problem there.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__8_May_2009_09_16_43_+1000_k9TYUvOiYIVpKda=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoDa9sACgkQjjKRsyhoI8yATgCeMBzhI3XB2q9QQCLwmjNbEdMf
KbkAnA8c3rJsNgkqUjMZjwiW1JJBsNgR
=KGJG
-----END PGP SIGNATURE-----

--Signature=_Fri__8_May_2009_09_16_43_+1000_k9TYUvOiYIVpKda=--

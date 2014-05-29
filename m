Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DA251A024E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 19:39:55 +1000 (EST)
Date: Thu, 29 May 2014 19:39:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Remove platforms/wsp and associated pieces
Message-ID: <20140529193950.2d6f788d@canb.auug.org.au>
In-Reply-To: <20140529193252.05902952@canb.auug.org.au>
References: <1401353429-29036-1-git-send-email-mpe@ellerman.id.au>
 <20140529193252.05902952@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sVkWHnsBTgpCYtJoHhMdHmt"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org, pebolle@tiscali.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/sVkWHnsBTgpCYtJoHhMdHmt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 29 May 2014 19:32:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 29 May 2014 18:50:29 +1000 Michael Ellerman <mpe@ellerman.id.au> =
wrote:
> >
> > __attribute__ ((unused))
> >=20
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>=20
> So this was the only use of CONFIG_PPC_A2 ... so more cleanup
> possible :-)

And also seems to be the only thing that selects CONFIG_PPC_ICSWX.
However, this is user selectable ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/sVkWHnsBTgpCYtJoHhMdHmt
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJThwBqAAoJEMDTa8Ir7ZwVTzQP/3A+Oh4bR+/XyvRLKR6ez7h8
XH/1zCaE2pyz4zgUHTEX16JG18GHGz3ycyGjHQMY+VyJzZFZ4+LIf1pxGyi6w9uk
ZKvVHaUW1EqzphT2+o5u4gy1z7DTFK2wcVbFgVzQt93PDQux68Xkp6tjy7KT3l6a
tabJikKe1qmTOxc15O2LF9oNwP7I7xxpwXIl62OfAdYLvuuLsXvlleNSGEF8ivsV
R/T08HN9pS1EYhxac8vHsKQTPocba90zdaiZNZuDH8JvHWe7oJvn6WW0HYqaOu6R
pIXELKTIhjx9/j4fgkiW1sgsbBYbXIomFeTpLC0K4x5b2zaevB8ZsL93jFH+X/X8
u3Mvm1gTnu/g1mYucByFWt6ocCbuHEi5DzS73PeBrVXa2n3NZgJHVwcmx2Bt+UDM
WbZsTBoiRd7YKOeqm1lDc0An3ktnfnMIwmIgVyJkeItEr0N3RVD/Ss9CqjX9pj5J
0QJgsgBRfB/c/Ong2do3heDXDpYbLuum+JBObBu7QtOFjY3YXIg1Sz3NDq3xqwdK
IU27CGK4QB0KSZy01mRZr0GlGy6kmACf0LDXHJbBi00kIbcTHqx6QUlTpHRRG3Ek
ySHsLn8E0J9hGTQVN7NzwODTlTqwVoODBIq91m5+UWUn0ofN6MGApUWtt2k0R2TO
i/ngXiKjTgvDYxwUhvq5
=vNbG
-----END PGP SIGNATURE-----

--Sig_/sVkWHnsBTgpCYtJoHhMdHmt--

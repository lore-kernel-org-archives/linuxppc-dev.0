Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4023Cf0v5szF09S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 20:27:42 +1100 (AEDT)
Date: Thu, 15 Mar 2018 20:27:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: more warnings
Message-ID: <20180315202712.4fc55702@canb.auug.org.au>
In-Reply-To: <CAKTCnz=4Fun3C5RMp1x3N+rmaU8-Yy3WOVZFyrc_5MNRKaYskg@mail.gmail.com>
References: <20180314162325.1b2dea8d@canb.auug.org.au>
 <CAKTCnz=4Fun3C5RMp1x3N+rmaU8-Yy3WOVZFyrc_5MNRKaYskg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0PUo8FeoOQ/tAiBgF5C1S/J"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/0PUo8FeoOQ/tAiBgF5C1S/J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Balbir,

On Thu, 15 Mar 2018 19:42:33 +1100 Balbir Singh <bsingharora@gmail.com> wro=
te:
>
> On Wed, Mar 14, 2018 at 4:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > I also get these from a powerpc allyesconfig build of linux-next:
> >
> > WARNING: vmlinux.o(.text+0x7c81c): Section mismatch in reference from t=
he function .stop_machine_change_mapping() to the function .meminit.text:.c=
reate_physical_mapping()
> > The function .stop_machine_change_mapping() references
> > the function __meminit .create_physical_mapping().
> > This is often because .stop_machine_change_mapping lacks a __meminit
> > annotation or the annotation of .create_physical_mapping is wrong.
> >
> > WARNING: vmlinux.o(.text+0x7c828): Section mismatch in reference from t=
he function .stop_machine_change_mapping() to the function .meminit.text:.c=
reate_physical_mapping()
> > The function .stop_machine_change_mapping() references
> > the function __meminit .create_physical_mapping().
> > This is often because .stop_machine_change_mapping lacks a __meminit
> > annotation or the annotation of .create_physical_mapping is wrong.
> > =20
>=20
> Patches have been sent to fix this - http://patchwork.ozlabs.org/patch/88=
3991/

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/0PUo8FeoOQ/tAiBgF5C1S/J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqPHAACgkQAVBC80lX
0GyfFggAl9AejZhFEcabZbkyEP9cAC4kY5MW7s5Zbu01CGmQxhfnZuktpTz2qQqF
iLOUzJT5UrEbniPlYp953lqEThwQgsKvUB44voa/atxkzsikqPvrMcsCwom/Z38q
hFi+cZsGyaiBzYa/AFk852N/zMTnmeycmXrJFFedUt0PDV8sdTJEZe0h5elBZ58A
88C6fg4V1rusRgZQa7tavDQK7ri9DmuOUYYlcyEU3cB6tx2PWOK/qU1A30LWk99d
KxgphiUDgRL7UJNABc35W1ba/NbqKyt7ES+vZOTqxY+QkISH6pl7DcyqaYebR8kO
CPGgORd/pMbSbisty3LCUONOmgft1A==
=ZJcB
-----END PGP SIGNATURE-----

--Sig_/0PUo8FeoOQ/tAiBgF5C1S/J--

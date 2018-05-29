Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wCYs0FQYzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:23:29 +1000 (AEST)
Date: Tue, 29 May 2018 22:23:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: boot messages from today's linux-next
Message-ID: <20180529222327.29d16eb6@canb.auug.org.au>
In-Reply-To: <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
References: <20180529210257.26da8de7@canb.auug.org.au>
 <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QVX.L/P4qjtv1+yvwEKFwpx"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/QVX.L/P4qjtv1+yvwEKFwpx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

On Tue, 29 May 2018 13:56:48 +0200 Mathieu Malaterre <malat@debian.org> wro=
te:
>
> On Tue, May 29, 2018 at 1:02 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> > Hi all,
> >
> > My qemu boots of today's powerpc linux-next kernel produced the followi=
ng
> > boot message differences:
> >
> > -Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
> > +Max number of cores passed to firmware: u (NR_CPUS =3D 2048)
> >
> > Seemingly caused by commit
> >
> >   eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf") =20
>=20
> My bad. Patch is pending (thanks Michael!):
>=20
> https://patchwork.ozlabs.org/patch/921948/

Umm, that fixes some other messages, but not this particular one.

--=20
Cheers,
Stephen Rothwell

--Sig_/QVX.L/P4qjtv1+yvwEKFwpx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNRj8ACgkQAVBC80lX
0GwSWAf/X+uepuMrYN2u3rwltVhmCwERj1SOYZwcok8zW/lT25+Ix8rZWes92Xm2
zadjH7cH0C9Umt7FTc8mnJ51WTKoPz8CKQzvdLGE1DBAEJtLtWdowPbK9BfEbbwN
DMnjQxekWX5/B7uwPczkRaI9QdqAnJnUAxhBfx+wJEkpXKqo6cfHvu2kcuhEyilw
rLU/L032uNC92sctqZfJfml9NN0wLy3FnVbSXC3gW9LkffIU2ZS39wus7HNlZLJm
Lg1qzZS2CagtyJ962TB090Fql4C8lAMEUZEvlCY0GXURh47CxJoLT0RhRFKKtver
T+P9RxiA90jtjs9eVvmsi5D4N5lbIw==
=22jt
-----END PGP SIGNATURE-----

--Sig_/QVX.L/P4qjtv1+yvwEKFwpx--

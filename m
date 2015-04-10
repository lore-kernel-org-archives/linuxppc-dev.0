Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48C2C1A1B6E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:42:13 +1000 (AEST)
Date: Fri, 10 Apr 2015 16:42:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
Message-ID: <20150410164208.1cc2a994@canb.auug.org.au>
In-Reply-To: <1428643714.30592.4.camel@ellerman.id.au>
References: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
 <20150410142414.0ea55c4b@canb.auug.org.au>
 <1428643714.30592.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2_w_OPnA_Z90.pQX=obyz9W"; protocol="application/pgp-signature"
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/2_w_OPnA_Z90.pQX=obyz9W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 10 Apr 2015 15:28:34 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Like this?
>=20
> $ git diff --stat -M HEAD^
>  arch/powerpc/platforms/pasemi/Makefile                            |  1 +
>  arch/powerpc/{sysdev/mpic_pasemi_msi.c =3D> platforms/pasemi/msi.c} |  4=
 +---
>  arch/powerpc/sysdev/Makefile                                      |  2 +-
>  arch/powerpc/sysdev/mpic.h                                        | 10 +=
++++-----
>  4 files changed, 8 insertions(+), 9 deletions(-)

Yeah, much easier to see what is going on.  And (I think) the diff
should work as long as it is only given to "git am" (et al) and not
"patch".

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/2_w_OPnA_Z90.pQX=obyz9W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJ3DEAAoJEMDTa8Ir7ZwVUEMP/1rJa3LidYxk73QJZC2z9srl
SueonBaY3JTIwgpLNn7raZYgHZyEezvhlQ2YwRJa8hoyPqLOyjVcoHwp8+0vBjkr
pxKIvCC/yWW6B0tf6rYgtELqZV14mLDcvxk3DIbXxWJDc8Vlzyl/bjrUwMBXR6fn
nkRkLM6HbjLwcZY10q8zZvObdRXNB0AAXcZJxjEhbj0yf6n6EsbmSMMY0o+LVaSu
MbIWPlkFKrTaRdt+8xrNcRrIHUvgJiJTzQXKv3pS6btS4ArmXmTGrjTuOb1RLZy2
QL13T29qmq1Qx8VJqIsNwqhXVKdOlQcIDoVbSfyHEEoy+1XvNFrsBAR7k+DNgEeO
r8HrmTCZfkwfyPlgxTv3UGoNyw2pQcwUep6fIOvdlPfZvS4sxTyGlTfgz/4pPu0N
a+huR32+htci5IraEmrTN4wNjJ9i550hM3GW4O2Y5/U3MUxQQawdbmU7XfKzgGYI
fqjR2o4yUyhRq9TN+OZ24RdN57kjNsth9v/3EHcCgcxWPIf/Ex/fBUbg5rTPzRkm
5xrgk2zR/x6SaTbeRB8RyYmUAAC6MvH7AXJMEJ6HOrtBykbkMu31v3HabnnYYUbn
Zau0+aSAVzxhjF7HBtq5FYoe1DJJ0/Pcudap0r13nQfNFfAabyGo1YJ2QC+kxdBq
fPudDIH7XqaTsxRuzKho
=K9EF
-----END PGP SIGNATURE-----

--Sig_/2_w_OPnA_Z90.pQX=obyz9W--

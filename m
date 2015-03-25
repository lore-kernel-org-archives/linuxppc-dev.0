Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 655911A0739
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 18:40:30 +1100 (AEDT)
Date: Wed, 25 Mar 2015 18:40:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 01/27] powerpc: move find_and_init_phbs() to pSeries
 specific code
Message-ID: <20150325184024.753acad0@canb.auug.org.au>
In-Reply-To: <1427261761-22952-2-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
 <1427261761-22952-2-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cRrxWw8SyxWb3Yi83+wGzBi"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/cRrxWw8SyxWb3Yi83+wGzBi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, 25 Mar 2015 16:35:35 +1100 Daniel Axtens <dja@axtens.net> wrote:
>
> Previously, find_and_init_phbs() was used in both PowerNV and pSeries
> setup. However, since RTAS support has been dropped from PowerNV, we
> can move it into a platform-specific file.
>=20
> This patch depends on the patch to drop RTAS support from PowerNV:
> http://patchwork.ozlabs.org/patch/449316/

In the future, you should put this sort of commentary (this last
paragraph) below the "---" line as we don't really want it in the
commit message, right?  This is more instructions to the
reviewers/committer than description of the change.

>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/include/asm/ppc-pci.h     |  3 ---
>  arch/powerpc/kernel/rtas_pci.c         | 47 ----------------------------=
------
>  arch/powerpc/platforms/pseries/setup.c | 47 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 47 insertions(+), 50 deletions(-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/cRrxWw8SyxWb3Yi83+wGzBi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVEmZtAAoJEMDTa8Ir7ZwVtnYP/i+cTWPOJzXyHtzzVsZJatrZ
YsHAiUnsZ+3mIo+OUVyKVoZ4X/YEqOdN2Anp59pFEoT37GblXaCUwPc1YaRJ0rRZ
EtQqWs+0N6SEHHGC+3TlJXhT66nOsl8Syfr4dUvPb/+ZuMMBINlkcoY9YZzDifVs
L6oyqPj64V2Q1tSqzst595dJrh8UFrnde2miSf3W/6eIYT5fFx9BW1v68pj2wpqi
L+xxlaWQQkFHPta2598t8nr8GkiBDDVEVUCO5gQ42QW0+KVcifDMYt2bQsBor22X
M+fON9KxxiHB89+1C4tEPt4kakiR2S3q3GiQdrflIIhJQuEwKCGYpCkxL2fgakWK
P61N076yoxDXnDhTU8s4ZIBFRiLxyJZszXSPN5wYU/I2HTV3RrDVsPNwsiexeiTG
ryLJ9OpYESbxhTX+wTgb+uCgjdheKNax6ihonSdNhY9v7eKkp1fLVAGruj9JvSwH
lpdLWZNJO706nfdy6FQcBGksSQvcAUZ0PIZrHoJ3sDyvEI8X1F/EE+yZ/tFBGwk7
Q8CGZdMmrEXA7b3AvwVtRPvwUZFmIxBvgWsg+oA/MNs5bwo/UEf3I16o+eCJg8Rv
C9bR5M6qADuP0LJO8w5yw+It832H2U3u+oEHt/jGyw1PKE4XFOvGE05sBGDZ12XD
/U2nC4mfnZpA3mEXjbG8
=BoZX
-----END PGP SIGNATURE-----

--Sig_/cRrxWw8SyxWb3Yi83+wGzBi--

Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53D1D1A0944
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:24:20 +1000 (AEST)
Date: Fri, 10 Apr 2015 14:24:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
Message-ID: <20150410142414.0ea55c4b@canb.auug.org.au>
In-Reply-To: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
References: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o3OaIag7jyaTEHqL+4+gaaH"; protocol="application/pgp-signature"
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/o3OaIag7jyaTEHqL+4+gaaH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 10 Apr 2015 11:52:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
>  arch/powerpc/platforms/pasemi/Makefile |   1 +
>  arch/powerpc/platforms/pasemi/msi.c    | 165 +++++++++++++++++++++++++++=
+++++
>  arch/powerpc/sysdev/Makefile           |   2 +-
>  arch/powerpc/sysdev/mpic.h             |  10 +-
>  arch/powerpc/sysdev/mpic_pasemi_msi.c  | 167 ---------------------------=
------
>  5 files changed, 172 insertions(+), 173 deletions(-)
>  create mode 100644 arch/powerpc/platforms/pasemi/msi.c
>  delete mode 100644 arch/powerpc/sysdev/mpic_pasemi_msi.c

What does this look like if you do "git diff --stat -M" and "git diff -M"?

This is very useful in cases where files are moved so that people can
see what changed when the file moved.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/o3OaIag7jyaTEHqL+4+gaaH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJ1BzAAoJEMDTa8Ir7ZwVMD8P/iromTkF17RN8p8HUXgv210O
cPRUppxwu/gF3Z9Hd58nt5r3n2/wD1tLAVa72lQ/8oHigucH9IQY6nKXqYaIqx4R
EhSiM3DKMB5jc7nFGxgp/Zf0x0YtcJ+1AklXRDoneArQocDV85hGec2ZcOiMFbZX
NYv5fI5aWL3qQC5NDBL/fGnhom0IHMgZfqqfYNYg75sa2HdLnp2M6ZZoa6ulfJgD
81SqOPDEZJts13QDsqSt97rNNaLkMseZx51Dvupe+E/oSg5wc0SrSglVcpgMT5H2
+36p9CelOWKgkaC2I720UmkxbHvR2dDumf4Fo0ZCdXJEQSTcnDD3TMcOz6uTiKEU
vIK4heuBw+Hzd8Ws5rbnOF1pTUOCOnwgSyR/USAyB7+FSArsJmG4A36z3YIs6f1v
Y3aPoGAanrKBxWtmUUTiadOlV9xxJOpyi4S5D3PEzDkkNR5FCOp1EAD8OOCFi/nt
VfkfpWlb/FeooshNiUdqFPDafX0XYWdAHjKSLQ9EL0Sh3TjA2tB0MY6rcivzrb06
nMbUKIAYOi6vthtP5e0GXWobmyY4CfCXoaLgGhVz6LWmqunImcMb3t0l0+QL00mE
inm8KPgV6XKMG9btpUoCOp+/QsEjhb0HwPr3ZdsweFyZOxyywcgkTbTfFdU2/Qo6
yXlfRbC7HP7OKS6kGmbj
=2BRO
-----END PGP SIGNATURE-----

--Sig_/o3OaIag7jyaTEHqL+4+gaaH--

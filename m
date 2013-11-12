Return-Path: <monstr@monstr.eu>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B7562C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 02:39:47 +1100 (EST)
Received: by mail-ee0-f51.google.com with SMTP id t10so3196538eei.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 07:39:43 -0800 (PST)
Message-ID: <52824BBC.9020401@monstr.eu>
Date: Tue, 12 Nov 2013 16:39:40 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1384262545-20875-1-git-send-email-msalter@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wakS2gO08XuamRTkaApEoSt4HdIMUTtMO"
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 James Hogan <james.hogan@imgtec.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, microblaze-uclinux@itee.uq.edu.au,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wakS2gO08XuamRTkaApEoSt4HdIMUTtMO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/12/2013 02:22 PM, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.=
h
> which is intended to be included from arch/*/include/asm/fixmap.h.
>=20
> This has been compiled on x86, arm, powerpc, and sh, but tested
> on x86 only.
>=20
> Mark Salter (11):
>   Add generic fixmap.h
>   x86: use generic fixmap.h
>   arm: use generic fixmap.h
>   hexagon: use generic fixmap.h
>   metag: use generic fixmap.h
>   microblaze: use generic fixmap.h
>   mips: use generic fixmap.h
>   powerpc: use generic fixmap.h
>   sh: use generic fixmap.h
>   tile: use generic fixmap.h
>   um: use generic fixmap.h
>=20
>  arch/arm/include/asm/fixmap.h        |  25 ++------
>  arch/hexagon/include/asm/fixmap.h    |  40 +------------
>  arch/metag/include/asm/fixmap.h      |  32 +----------
>  arch/microblaze/include/asm/fixmap.h |  44 +-------------
>  arch/mips/include/asm/fixmap.h       |  33 +----------
>  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
>  arch/sh/include/asm/fixmap.h         |  39 +------------
>  arch/tile/include/asm/fixmap.h       |  33 +----------
>  arch/um/include/asm/fixmap.h         |  40 +------------
>  arch/x86/include/asm/fixmap.h        |  59 +------------------
>  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++=
++++++++
>  11 files changed, 125 insertions(+), 371 deletions(-)
>  create mode 100644 include/asm-generic/fixmap.h

Any repo/branch with all these patches will be helpful.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--wakS2gO08XuamRTkaApEoSt4HdIMUTtMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKCS7wACgkQykllyylKDCEq9QCffe3d/+9UQGGG/rdCAxD81tq3
sRQAmwaBtQ/8lmwDm9Eo3vmovL9WeRiE
=R0bw
-----END PGP SIGNATURE-----

--wakS2gO08XuamRTkaApEoSt4HdIMUTtMO--

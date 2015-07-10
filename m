Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D94A1A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 17:53:41 +1000 (AEST)
Message-ID: <1436514813.32041.1.camel@ellerman.id.au>
Subject: [git pull] Please pull powerpc/linux.git powerpc-4.2-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, anton@samba.org, dja@axtens.net,
 imunsie@au1.ibm.com,  jk@ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  maninder1.s@samsung.com, mikey@neuling.org,
 shreyas@linux.vnet.ibm.com,  sukadev@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Jul 2015 17:53:33 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-ENqECi37/QZRbBk6nH2y"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ENqECi37/QZRbBk6nH2y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc fixes for 4.2:

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754=
:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.2-2

(Note this has moved from mpe/linux.git since my last pull, Ben & I now hav=
e a
 shared powerpc tree)

for you to fetch changes up to 2c069a118fe1d80c47dca84e1561045fc7f3cc9e:

  cxl: Check if afu is not null in cxl_slbia (2015-07-10 11:44:25 +1000)

----------------------------------------------------------------
powerpc fixes for 4.2

- opal-prd mmap fix from Vaidy.
- Set kernel taint for MCEs from Daniel.
- Alignment exception description from Anton.
- ppc4xx_hsta_msi build fix from Daniel
- opal-elog interrupt fix from Alistair.
- core_idle_state race fix from Shreyas.
- hv-24x7 lockdep fix from Sukadev.
- Multiple cxl fixes from Daniel, Ian, Mikey & Maninder.
- Update MAINTAINERS to point at shared tree.

----------------------------------------------------------------
Alistair Popple (1):
      powerpc/powernv: Fix opal-elog interrupt handler

Anton Blanchard (1):
      powerpc: Add plain English description for alignment exception oopses

Daniel Axtens (4):
      powerpc: Set the correct kernel taint on machine check errors.
      cxl: Test the correct mmio space before unmapping
      powerpc/ppc4xx_hsta_msi: Include ppc-pci.h to fix reference to hose_l=
ist
      cxl: Check if afu is not null in cxl_slbia

Ian Munsie (2):
      cxl: Fail mmap if requested mapping is larger than assigned problem s=
tate area
      cxl: Fix off by one error allowing subsequent mmap page to be accesse=
d

Maninder Singh (1):
      cxl/vphb.c: Use phb pointer after NULL check

Michael Ellerman (1):
      powerpc: Update MAINTAINERS to point at shared tree

Michael Neuling (1):
      cxl: Fix refcounting in kernel API

Shreyas B. Prabhu (1):
      powerpc/powernv: Fix race in updating core_idle_state

Sukadev Bhattiprolu (1):
      powerpc/perf/24x7: Fix lockdep warning

Vaidyanathan Srinivasan (1):
      powerpc/powernv: Fix vma page prot flags in opal-prd driver

 MAINTAINERS                                |  2 +-
 arch/powerpc/kernel/idle_power7.S          | 31 ++++++++++++++++++++------=
----
 arch/powerpc/kernel/traps.c                |  2 ++
 arch/powerpc/mm/fault.c                    |  4 ++++
 arch/powerpc/perf/hv-24x7.c                |  2 ++
 arch/powerpc/platforms/powernv/opal-elog.c | 16 +++++----------
 arch/powerpc/platforms/powernv/opal-prd.c  |  9 ++++-----
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c      |  1 +
 drivers/misc/cxl/api.c                     | 12 +++++-------
 drivers/misc/cxl/context.c                 | 14 +++++++++++---
 drivers/misc/cxl/main.c                    |  2 +-
 drivers/misc/cxl/pci.c                     |  2 +-
 drivers/misc/cxl/vphb.c                    |  3 ++-
 13 files changed, 60 insertions(+), 40 deletions(-)



--=-ENqECi37/QZRbBk6nH2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVn3n+AAoJEFHr6jzI4aWA+FsP/26Qf2fms/V7G64G5uTrD7Kx
SVLHNe/aY9oaq92bcdmdpVqe4nlY7ncGOsP8FtxIZeMyM2ueLCQXWvalNInuI3QA
uaJm+O/mquTOB1sw5I3clI4npqeG0gwiDIcfkhBbi/DgS4QaWxRBc3f+o0qsFU2I
E2NLDcz/xLoHrwhepxwRfoQkvkwuS6+vWUqt77+kIVswVCzFtWWTFGHj6YJPOAE8
FZT6UPwGspTnqQcPnNoSmL8GOpAn9LyOeywWjqjAyN69xJlnv+IrghVQzGunNGro
gEbI1iUJZS7etybKv0ajpgQyUTs/31did6KGEl2bGrgHlFI4SctvjbKQcL9jV0wo
LYZ938h+UVQKq2r/EMXbmp71MX3NEqk6+OIAaoMj2HYKGByPpnVG1qt0YnFtukyn
blFmjMQHy9/jVyIT8pQNaGRyVIN3SQVAHHXbCD9mvzt1H3PW1Dy85EqD5rVbFnLp
VdV51AKL4uc95AJZ3c1VQWQepCw4xz4MHrRn8wwEIKPxDZTTL/fmMxoVK/45mu1u
Xjh2RH49o9EbmVEdjnl9XGFcIveKArGbZ9sL6UrCQ5kdz39NKpipoEoDkunE/7yu
XlSH68TZO0N80cTbLDfLd5NKBEVsgy7xKtHgVbVAr+ZrcYH08XR+h4T/cbmiqaEG
Qd4NNlPYMAFWJTDIjdFH
=nXHJ
-----END PGP SIGNATURE-----

--=-ENqECi37/QZRbBk6nH2y--

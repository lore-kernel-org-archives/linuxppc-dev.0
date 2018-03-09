Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyPQY371dzF1vF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 21:54:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alastair@d-silva.org, andrew.donnellan@au1.ibm.com,
 bharata@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linux@roeck-us.net,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-5 tag
Date: Fri, 09 Mar 2018 21:54:27 +1100
Message-ID: <87fu59v7rw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull some more powerpc fixes for 4.16:

The following changes since commit eb0a2d2620ae431c543963c8c7f08f597366fc60:

  powerpc/powernv: Support firmware disable of RFI flush (2018-02-23 16:55:42 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.16-5

for you to fetch changes up to b0c41b8b6e43120d7c35e4709508a3d90a09646e:

  powerpc/pseries: Fix vector5 in ibm architecture vector table (2018-03-06 23:05:38 +1100)

----------------------------------------------------------------
powerpc fixes for 4.16 #5

One notable fix to properly advertise our support for a new firmware feature,
caused by two series conflicting semantically but not textually.

There's a new ioctl for the new ocxl driver, which is not a fix, but needed to
complete the userspace API and good to have before the driver is in a released
kernel.

Finally three minor selftest fixes, and a fix for intermittent build failures
for some obscure platforms, caused by a missing make dependency.

Thanks to:
  Alastair D'Silva, Bharata B Rao, Guenter Roeck.

----------------------------------------------------------------
Alastair D'Silva (2):
      ocxl: Add get_metadata IOCTL to share OCXL information to userspace
      ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL

Bharata B Rao (1):
      powerpc/pseries: Fix vector5 in ibm architecture vector table

Guenter Roeck (1):
      powerpc/boot: Fix random libfdt related build errors

Michael Ellerman (3):
      selftests/powerpc: Skip tm-trap if transactional memory is not enabled
      selftests/powerpc: Fix missing clean of pmu/lib.o
      selftests/powerpc: Skip the subpage_prot tests if the syscall is unavailable

 Documentation/accelerators/ocxl.rst               |  5 +++++
 arch/powerpc/boot/Makefile                        |  3 ++-
 arch/powerpc/kernel/prom_init.c                   |  1 -
 drivers/misc/ocxl/file.c                          | 27 +++++++++++++++++++++++
 include/uapi/misc/ocxl.h                          | 17 ++++++++++++++
 tools/testing/selftests/powerpc/mm/subpage_prot.c | 14 ++++++++++++
 tools/testing/selftests/powerpc/tm/Makefile       |  2 +-
 tools/testing/selftests/powerpc/tm/tm-trap.c      |  2 ++
 8 files changed, 68 insertions(+), 3 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaomfjAAoJEFHr6jzI4aWAu24P/08vQm/fOi9+IGFpzYHycE5F
C6Xgc2/CBzIwSxOirCvnIYPQrbr/FlP9ms+LqVgyndhGDF1Offc46moXQGjOpoiC
LdaZrbGfM8By2zDAPMFILuwdERALMl6EIbgyVmJatDMDnV95IzDgtapwYVNI29F+
whuFayavuPA0FWfsPU3cx+Txjs5h4kKoFSN6QtbleEF827U+V6pa6OsMeIbjHvC1
gPz2o1FwxXYpV88TMpPGV1YczozaNV9VGcGUwFIVbgPGwADVamMiCw4qu3bjhFoW
9HrSrn6WhO6rXa7PvodPSBwn/UyaOZtzRlFmhuGJs3NqgTooNpY9SzJFmd0OlkXG
bHz8bQ6Qr/00joVe0c9e/g/DCDc9qlI+tZ+Xx55M7nQDyDIcGG9O2IMzxJXjz96S
I2J31VodW/31n5f/JZJp6AaJqiA2VypUrMb0NnVH6PUecOoSf78z/d/2oYzld0ZH
etW7NdDiq5RYXeV3HcqQ73yXZsTEUrIhWSUH1kETLI+GoqgLHCz4dAhu+K6vSd9M
fCJGKd5seWMvOSjLKauXFNyCB1YZfJI2nZTGV76NNl8eFEtgwgA44cVCr9W40Bms
7RIREyuAfLUFyLEWrCJyJSt1OdXjso42TBShx2A8z4sMYVUF0pn1YtTXzopcMqfP
jioeAXaBxgvspCbfv84u
=2cgm
-----END PGP SIGNATURE-----
--=-=-=--

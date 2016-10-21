Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t10q24TdtzDvH2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 09:34:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 fbarrat@linux.vnet.ibm.com, hkallweit1@gmail.com, imunsie@au1.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sfr@canb.auug.org.au, vaibhav@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-3 tag
Date: Sat, 22 Oct 2016 09:34:36 +1100
Message-ID: <871sz9z5z7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
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

Please pull some more powerpc fixes for 4.9:

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.9-3

for you to fetch changes up to 78914ff0843623ee6dbeae92fa0bb8761828684e:

  powerpc: Ignore the pkey system calls for now (2016-10-19 20:36:24 +1100)

----------------------------------------------------------------
powerpc fixes for 4.9 #3

Fixes marked for stable:
 - Prevent unlikely crash in copro_calculate_slb() (Frederic Barrat)
 - cxl: Prevent adapter reset if an active context exists (Vaibhav Jain)

Fixes for code merged this cycle:
 - Fix boot on systems with uncompressed kernel image (Heiner Kallweit)
 - Drop dump_numa_memory_topology() (Michael Ellerman)
 - Fix numa topology console print (Aneesh Kumar K.V)
 - Ignore the pkey system calls for now (Stephen Rothwell)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc: Fix numa topology console print

Frederic Barrat (1):
      powerpc/mm: Prevent unlikely crash in copro_calculate_slb()

Heiner Kallweit (1):
      powerpc/boot: Fix boot on systems with uncompressed kernel image

Michael Ellerman (1):
      powerpc/mm: Drop dump_numa_memory_topology()

Stephen Rothwell (1):
      powerpc: Ignore the pkey system calls for now

Vaibhav Jain (1):
      cxl: Prevent adapter reset if an active context exists

 Documentation/ABI/testing/sysfs-class-cxl |  7 +++--
 arch/powerpc/boot/main.c                  | 18 ++++++++++--
 arch/powerpc/include/asm/unistd.h         |  4 +++
 arch/powerpc/mm/copro_fault.c             |  2 ++
 arch/powerpc/mm/numa.c                    | 46 ++++---------------------------
 drivers/misc/cxl/api.c                    |  9 ++++++
 drivers/misc/cxl/context.c                |  3 ++
 drivers/misc/cxl/cxl.h                    | 24 ++++++++++++++++
 drivers/misc/cxl/file.c                   | 11 ++++++++
 drivers/misc/cxl/guest.c                  |  3 ++
 drivers/misc/cxl/main.c                   | 42 +++++++++++++++++++++++++++-
 drivers/misc/cxl/pci.c                    |  2 ++
 drivers/misc/cxl/sysfs.c                  | 27 +++++++++++++++---
 13 files changed, 148 insertions(+), 50 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCpf8AAoJEFHr6jzI4aWAGz0P/200Na1ff0dLKxUP2GYjoX4/
KlaZJWDEMfkVtEEb6hYF8fRDBjRzFU6JstcnoEZl9w9caJ7v2/C5dwldV/rQ/a1X
sgQuMvDUPdcMfDv/4UKWFls66TcCbp/ydZJDeOVmCroVMCZLNHsvguqT+flTjtrz
N56GVxojx/Bg/PdP9Q1TomcP280injzbAD4liVAl8tio2E0NJlCKA/o30+zif5gR
CiprCvuhzeNjTSizcxKD88R0sxoxTChnsXe0j+W+1ArQbawWy4uc5N/r1FF4qiyD
mYYOXRhp9rnbqxWYTI6jziFnF1i6nnG7KHjhKN1CbYJmAS2wTxYBhFqEj9NwEVp9
n57wwwIKJHLbappDrBpompkXlJKLIudrnN4O+nlgC5d0pxwDUJFjgwSESrsuIvue
4l/0RXWhpT8h1cIKRS7z4csOPMN3Ya4UjIUP8tZbLiuhjpXqT5sxJ8NTLrJDJ/en
kA/6SaWClevjbbLYRRStkBS4GeHvAnyDOOJZExAodcP74eVThcc0FXIsxeYf6bwA
+lmhOLzVo8lFV9EP1ug9giBqc2TYtjRAQTCDywIysvgKbs87IaRjiMhdwnpGgbJH
5jize05ixXW+6rIbxTyzoPBzNEfI52SeXRLAQuQhRx/V7YEj+NEXzjKxEcwkgdt8
C7YM7NB7eRV07s/XGFOn
=5V75
-----END PGP SIGNATURE-----
--=-=-=--

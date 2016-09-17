Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbmBl53lKzDsdw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Sep 2016 18:53:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds  <torvalds@linux-foundation.org>
Cc: ego@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-6 tag
Date: Sat, 17 Sep 2016 18:52:52 +1000
Message-ID: <87vaxunc0r.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.8:

The following changes since commit f077aaf0754bcba0fffdbd925bc12f09cd1e38aa:

  powerpc/mm: Don't alias user region to other regions below PAGE_OFFSET (2016-09-08 13:15:33 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.8-6

for you to fetch changes up to ed7d9a1d7da6fe7b1c7477dc70e95051583fd60c:

  powerpc/powernv/pci: Fix missed TCE invalidations that should fallback to OPAL (2016-09-15 17:05:11 +1000)

----------------------------------------------------------------
powerpc fixes for 4.8 #6

Fixes for code merged this cycle:
 - Fix restore of SPRs upon wake up from hypervisor state loss from Gautham R. Shenoy
 - Fix the state of root PE from Gavin Shan
 - Detach from PE on releasing PCI device from Gavin Shan
 - Fix size of NUM_CPU_FTR_KEYS on 32-bit
 - Fix missed TCE invalidations that should fallback to OPAL

----------------------------------------------------------------
Gautham R. Shenoy (1):
      powerpc/powernv: Fix restore of SPRs upon wake up from hypervisor state loss

Gavin Shan (2):
      powerpc/powernv: Fix the state of root PE
      powerpc/powernv: Detach from PE on releasing PCI device

Michael Ellerman (2):
      powerpc/kernel: Fix size of NUM_CPU_FTR_KEYS on 32-bit
      powerpc/powernv/pci: Fix missed TCE invalidations that should fallback to OPAL

 arch/powerpc/include/asm/cpu_has_feature.h |  2 +-
 arch/powerpc/kernel/idle_book3s.S          | 10 +++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c  | 26 +++++++++++++++++++++++---
 3 files changed, 29 insertions(+), 9 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3QRlAAoJEFHr6jzI4aWArj0QALw1tS8UMdfBPQoWbrLzBey9
ui1CKKin9tVO46PAyaXUC5PEuC8BRT5Thboh3CtFnuMdsJTfSHRunB7qreDPZ1ag
m6zv6Jr3HaM+JEVR89jN6ei7VgH3juMcLzuTWBwts9KBns3allqEb8wbAYuzpqo2
xOF9Lw1WwPYta21u+cl2FjTkx4fo0K+Sy1QGN9/gBVMhIJmXnagZ7XP8e70Ha/CZ
gQS8aWbLpr4gy4I7uVvcEH1rI5KCfFOm9bUSsDXpenr56l3ifaLMNF2/P8XMHce6
eVePQSPwt9Bz6lGBv5EAEd2dDiMgs+oOVV3fhCk22ze/I0m3t11eXPz3S9SlS5xC
7Grp9FjOJKBQ9vDC6KqWA4sId10WhNbA2tC2iE8MhGrmTKkkNTq6m4NZZqSt0Y0a
XL/dWtUWr6O8JhSW3hgalZ6wxjgbptM7gDPTN1x6cdQ2xo6bFRHCS3FEEYQlD7eL
QPb0N/6IKDGXD9LrXo5PzLUOXE9TuitlbREQIFojzjeBECNosCSN2+JkvJIRKmYm
5X0YrnOhpbmGEVj6v6i+O9sCQU8fNaA2vYX6TO2a0VQ/WQFsK/IkWIUN+xu3r3N0
o6/oqZGiWNJsDLl6PXZISrhbnEk+OJiTizn/rqLHv5VvkcRC37l/fY+5nQ8rbqDS
+Qm06G4uwcxeeAQeWn/A
=Vw1F
-----END PGP SIGNATURE-----
--=-=-=--

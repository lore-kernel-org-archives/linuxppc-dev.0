Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B1FC1A07B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 13:05:53 +1100 (AEDT)
Message-ID: <1455933946.17239.0.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.5-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, aneesh.kumar@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com,  kda@linux-powerpc.org,
 kirill.shutemov@linux.intel.com,  linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, rostedt@goodmis.org,  schwab@linux-m68k.org
Date: Sat, 20 Feb 2016 13:05:46 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-H+j49cSRRywpoiYlrLI2"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-H+j49cSRRywpoiYlrLI2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.5:

The following changes since commit 2d19fc639516dc7b4184450b315c931d38549e61=
:

  powerpc/mm: Fixup _HPAGE_CHG_MASK (2016-01-28 23:49:43 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.5-3

for you to fetch changes up to 6ecad912a0073c768db1491c27ca55ad2d0ee68f:

  powerpc/ioda: Set "read" permission when "write" is set (2016-02-17 23:52=
:17 +1100)

----------------------------------------------------------------
powerpc fixes for 4.5 #2

 - Fix build error on 32-bit with checkpoint restart from Aneesh Kumar
 - Fix dedotify for binutils >=3D 2.26 from Andreas Schwab
 - Don't trace hcalls on offline CPUs from Denis Kirjanov
 - eeh: Fix stale cached primary bus from Gavin Shan
 - eeh: Fix stale PE primary bus from Gavin Shan
 - mm: Fix Multi hit ERAT cause by recent THP update from Aneesh Kumar K.V
 - ioda: Set "read" permission when "write" is set from Alexey Kardashevski=
y

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/ioda: Set "read" permission when "write" is set

Andreas Schwab (1):
      powerpc: Fix dedotify for binutils >=3D 2.26

Aneesh Kumar K.V (2):
      powerpc/book3s_32: Fix build error with checkpoint restart
      powerpc/mm: Fix Multi hit ERAT cause by recent THP update

Denis Kirjanov (1):
      powerpc/pseries: Don't trace hcalls on offline CPUs

Gavin Shan (2):
      powerpc/eeh: Fix stale cached primary bus
      powerpc/powernv: Fix stale PE primary bus

 arch/powerpc/Kconfig                         |  4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++++
 arch/powerpc/include/asm/eeh.h               |  1 +
 arch/powerpc/include/asm/trace.h             |  8 +++++--
 arch/powerpc/kernel/eeh_driver.c             |  3 +++
 arch/powerpc/kernel/eeh_pe.c                 |  2 +-
 arch/powerpc/kernel/module_64.c              |  2 +-
 arch/powerpc/mm/pgtable_64.c                 | 32 ++++++++++++++++++++++++=
++++
 arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++++-
 arch/powerpc/platforms/powernv/pci-ioda.c    |  1 +
 arch/powerpc/platforms/powernv/pci.c         | 26 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 include/asm-generic/pgtable.h                |  8 +++++++
 mm/huge_memory.c                             |  1 +
 14 files changed, 91 insertions(+), 7 deletions(-)

--=-H+j49cSRRywpoiYlrLI2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWx8n6AAoJEFHr6jzI4aWAJzsQALIILIviLBkb9fDxOv5sYx2n
aH6jEnSVyW0HgHMalW2zS5a7x+ZBHuEIUcY5G5I2eac5bKNtqd6Zx3ZlnMzN6fNs
8ZbEMQEp82ajOYHsF+48h31+3GCdMxqCaMAV+8rLGUaFWUYVxYl8fNSiTsOfeGx1
qdqLRKApZOH9+5k9Tht1IxUZVPC15RDH8TCmjxqNEgPdqMbx0wyIUjXqPMfhIcK5
nlN0Wf5sUJZd87Lrji0oRKyVCIgZZlDoUxLpQsK1Qx8lZS6/6O/0P5pLVPJvHfQy
uHEAkrXc5XvjtL3KF4TDW3NJaSWJU+N7f9vHLs2EkEi33XmTPRGjLobAfY4uAB9K
kp/PO3nnXyJf4/qJ4XVvyA1LJ9ozre/IRkMEk3s3yjLwHKLKkUjDZ0wEQ3xoRrwk
iXyUmvvI9/DuU3W5PCh0KdOBnUHRnQuSc2RKZloQ5oUV5UH7QddyzOpWAslGCmy7
hhL6VTGias4G1KYmhHlWxtFgWVTISRok9qJT/RozD892suDdggE+0LhyVY8XMvw9
c2XNMg5W4jRuwX4XMwVIPmBRthQZQWTVyXrOo66GgzuGJf2IL04agbypSK/XTcp6
zXcBcAv3RHO5XnFKLT6ijNHK7boW6K/+PE8T9xQU7Ex/TKiwegCGXrmqotnsAIEc
EzlA0q0StxnI4mQMW2bZ
=2JiH
-----END PGP SIGNATURE-----

--=-H+j49cSRRywpoiYlrLI2--

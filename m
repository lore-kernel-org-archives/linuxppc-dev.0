Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5Hn56nkrzDvSW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 09:02:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 ego@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 paulus@ozlabs.org, segher@kernel.crashing.org, vaibhav@linux.vnet.ibm.com,
 valentinrothberg@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-4 tag
Date: Sat, 29 Oct 2016 09:02:48 +1100
Message-ID: <87eg302ktz.fsf@concordia.ellerman.id.au>
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

The following changes since commit 78914ff0843623ee6dbeae92fa0bb8761828684e:

  powerpc: Ignore the pkey system calls for now (2016-10-19 20:36:24 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.9-4

for you to fetch changes up to fb479e44a9e240a23c2d208c2ace23542a47f41c:

  powerpc/64s: relocation, register save fixes for system reset interrupt (2016-10-27 21:55:14 +1100)

----------------------------------------------------------------
powerpc fixes for 4.9 #4

Fixes marked for stable:
 - Convert cmp to cmpd in idle enter sequence (Segher Boessenkool)
 - cxl: Fix leaking pid refs in some error paths (Vaibhav Jain)
 - Re-fix race condition between going idle and entering guest (Paul Mackerras)
 - Fix race condition in setting lock bit in idle/wakeup code (Paul Mackerras)
 - radix: Use tlbiel only if we ever ran on the current cpu (Aneesh Kumar K.V)
 - relocation, register save fixes for system reset interrupt (Nicholas Piggin)

Fixes for code merged this cycle:
 - Fix CONFIG_ALIVEC typo in restore_tm_state() (Valentin Rothberg)
 - KVM: PPC: Book3S HV: Fix build error when SMP=n (Michael Ellerman)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/radix: Use tlbiel only if we ever ran on the current cpu

Michael Ellerman (1):
      KVM: PPC: Book3S HV: Fix build error when SMP=n

Nicholas Piggin (1):
      powerpc/64s: relocation, register save fixes for system reset interrupt

Paul Mackerras (2):
      powerpc/64: Re-fix race condition between going idle and entering guest
      powerpc/64: Fix race condition in setting lock bit in idle/wakeup code

Segher Boessenkool (1):
      powerpc: Convert cmp to cmpd in idle enter sequence

Vaibhav Jain (1):
      cxl: Fix leaking pid refs in some error paths

Valentin Rothberg (1):
      powerpc/process: Fix CONFIG_ALIVEC typo in restore_tm_state()

 arch/powerpc/include/asm/cpuidle.h       |  2 +-
 arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
 arch/powerpc/include/asm/tlb.h           | 12 ++++++++
 arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
 arch/powerpc/kernel/idle_book3s.S        | 35 ++++++++++++++++++----
 arch/powerpc/kernel/process.c            |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c     |  1 +
 arch/powerpc/mm/tlb-radix.c              |  8 ++---
 drivers/misc/cxl/api.c                   |  2 ++
 drivers/misc/cxl/file.c                  | 22 ++++++++------
 10 files changed, 108 insertions(+), 42 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYE8sIAAoJEFHr6jzI4aWAJJgQAKAKK0xQKyzfGISEdtnjg3vc
myLi5wIGSHHkXvQP9/9FbcaPEjIvtPjaevAV39xKdCreNcDNZxAta32MtQST56AN
RT8mHjgVzdE1pTY5ts0hBvrfipejNwUzCklh9IY9ysGSzTG7Kjp4F86PvdPUJSXF
nX9AX9JGllnwMNM0BlFGf5530fsH4W4dlLt2SRBJrRS2trnbDJHWAmvqYkHDls1q
7b19rdzpRIzZgNQQN8wwOQBLEJ/HIJpU+0K/PXHoGuojMHXzZM8dgmq+2k0UnCnX
VSG+31Hc7GFSaEozT2s3OllHUxnlOoeCLYJhM5gEPY+aLZxbxjEif6fdi4vSJFsa
1WsfXtLf7/TXga/1OS1e+rNB2fHfKgMcDT0CzHHt+olHn61c/l1kDOGCgQApibpb
xagmRY3baXiV23AZGDumKm9bBN991wZ9RY3DVgrDNarVNuiawkOpsGe/RbePRasx
0KWookq1TsWbqISunnFGLILUzQKDAarDWGxSvdAZfJiS09/6WHJd7y2R7MEHe2ZW
UxTtEIVsS76LJUBCg98f3odMiEN1kxZOzG6f8EKewQVQZcyv65bSFReJFe4menHW
u6o2yYrq+hIcGEKXJ4dZ1FZq8na0czNPDvJ9gdGxEu8Zonx6Xk2QVa9yMPckmUqP
gSNI2pZ4DrItvdzOvki6
=vzpb
-----END PGP SIGNATURE-----
--=-=-=--

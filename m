Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9D181A0CA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 08:56:37 +1000 (AEST)
Message-ID: <1429916196.8599.1.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.1-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Apr 2015 08:56:36 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-3YrgJShytr+cQp5k0PMk"
Mime-Version: 1.0
Cc: scottwood@freescale.com, shreyas@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3YrgJShytr+cQp5k0PMk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc fixes for 4.1:

The following changes since commit d19d5efd8c8840aa4f38a6dfbfe500d8cc27de46=
:

  Merge tag 'powerpc-4.1-1' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/mpe/linux (2015-04-16 13:53:32 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.1-2

for you to fetch changes up to 2e826695d87c2d213def07bc344ae97d88384f62:

  powerpc/mm: Fix build error with CONFIG_PPC_TRANSACTIONAL_MEM disabled (2=
015-04-23 17:42:14 +1000)

----------------------------------------------------------------
powerpc fixes for 4.1

- Fix for mm_dec_nr_pmds() from Scott.
- Fixes for oopses seen with KVM + THP from Aneesh.
- Build fixes from Aneesh & Shreyas.

----------------------------------------------------------------
Aneesh Kumar K.V (5):
      KVM: PPC: Use READ_ONCE when dereferencing pte_t pointer
      KVM: PPC: Remove page table walk helpers
      powerpc/mm/thp: Make page table walk safe against thp split/collapse
      powerpc/mm/thp: Return pte address if we find trans_splitting.
      powerpc/mm: Fix build error with CONFIG_PPC_TRANSACTIONAL_MEM disable=
d

Michael Ellerman (1):
      Merge branch 'master' of git://git.kernel.org/.../scottwood/linux int=
o fixes

Scott Wood (1):
      powerpc/hugetlb: Call mm_dec_nr_pmds() in hugetlb_free_pmd_range()

Shreyas B. Prabhu (1):
      powerpc/kvm: Fix ppc64_defconfig + PPC_POWERNV=3Dn build error

 arch/powerpc/include/asm/kvm_book3s_64.h | 17 +++----
 arch/powerpc/include/asm/pgtable.h       | 28 +++--------
 arch/powerpc/kernel/eeh.c                |  6 ++-
 arch/powerpc/kernel/io-workarounds.c     | 10 ++--
 arch/powerpc/kvm/Kconfig                 |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 14 +++---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 86 +++++++++++++++++-----------=
----
 arch/powerpc/kvm/e500_mmu_host.c         | 32 ++++++++----
 arch/powerpc/mm/hash_utils_64.c          |  3 +-
 arch/powerpc/mm/hugetlbpage.c            | 32 ++++++++----
 arch/powerpc/perf/callchain.c            | 24 +++++----
 11 files changed, 137 insertions(+), 117 deletions(-)



--=-3YrgJShytr+cQp5k0PMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVOsokAAoJEFHr6jzI4aWAe7oQAJSTttpz7Zl/SNQwMfOt44/y
GcAfeRMN2XAYU8zdN6DHNGmO7SaTZsstzWH05qJEYprjiuELg4zZ+dMTLuMQ0g8g
xeeNhmdw7l3y133Dr/wVNNgxlNrQvYvtdR1QEdXBQaWZLWyzeWCETOeFsikJp5a/
niuYMCFlX/+ci8DzMdvVSlYlHT/w61bx4tvU48ll9EYWMzW15oP29F9/wI4eGOaC
S3yxdCONtb0yxUKQTHRAN9rkaBPnKC4KUuBFk5LWUOdt1L/AzF+vKInu/0GDvPRb
jV8Meuzng6SSTPRRk8ULdHMydQrs4jbM5ELye0DSdIfU24BgjfZVJpBFz9eDrzjv
nlZwiIoT0AXWw/uofVjJwRW81i9Z/o2FSkpgIwnOEX8whD1+woqbTRaf/+mKj03p
VgUP9+RjYKIVFFtoMo3EWTz2VtbIsD+YzbGNBSYcKdNfYXQvWGFkpnKHUgLCFR0l
WLJpsGcGC3ANDqJYvDqh1T6YiSPjFq429+RcLiRepV82Fe8hsLL7rrNs4tHGQ8yI
viRgYZDwRcwCiXerGozvMF9H3cNpQh5s1wIBQBZH/w3rjalU0EUAVBmanl5fJqvj
ZJadMGnd6nCCtypQk4ZZDjk1IoqVOFSP6KxQyG5dcK2cWCX8+1eeUJychkYGDj5E
g4+l4+Nx0gPpynHfyivI
=TMeh
-----END PGP SIGNATURE-----

--=-3YrgJShytr+cQp5k0PMk--

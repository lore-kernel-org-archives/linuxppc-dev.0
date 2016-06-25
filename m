Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rcC4c1ZkFzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 21:04:00 +1000 (AEST)
Message-ID: <1466852633.3259.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, cascardo@redhat.com,
 gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com
Date: Sat, 25 Jun 2016 21:03:53 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-GzX7Rau4ichwkXu+glmk"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-GzX7Rau4ichwkXu+glmk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.7:

The following changes since commit 8017ea35d33f9e0950d369773ab48bcb1efb9ba0=
:

  powerpc/nohash: Fix build break with 64K pages (2016-06-10 13:24:56 +1000=
)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.7-4

for you to fetch changes up to 844e3be47693f92a108cb1fb3b0606bf25e9c7a6:

  powerpc/bpf/jit: Disable classic BPF JIT on ppc64le (2016-06-23 10:35:31 =
+1000)

----------------------------------------------------------------
powerpc fixes for 4.7 #4

 - mm/radix: Update to tlb functions ric argument from Aneesh Kumar K.V
 - mm/radix: Flush page walk cache when freeing page table from Aneesh Kuma=
r K.V
 - mm/hash: Use the correct PPP mask when updating HPTE from Aneesh Kumar K=
.V
 - mm/hash: Don't add memory coherence if cache inhibited is set from Anees=
h Kumar K.V
 - mm/radix: Update Radix tree size as per ISA 3.0 from Aneesh Kumar K.V
 - eeh: Fix invalid cached PE primary bus from Gavin Shan
 - Fix faults caused by radix patching of SLB miss handler from Michael Ell=
erman
 - bpf/jit: Disable classic BPF JIT on ppc64le from Naveen N. Rao

----------------------------------------------------------------
Aneesh Kumar K.V (5):
      powerpc/mm/radix: Update to tlb functions ric argument
      powerpc/mm/radix: Flush page walk cache when freeing page table
      powerpc/mm/hash: Use the correct PPP mask when updating HPTE
      powerpc/mm/hash: Don't add memory coherence if cache inhibited is set
      powerpc/mm/radix: Update Radix tree size as per ISA 3.0

Gavin Shan (1):
      powerpc/eeh: Fix invalid cached PE primary bus

Michael Ellerman (1):
      powerpc: Fix faults caused by radix patching of SLB miss handler

Naveen N. Rao (1):
      powerpc/bpf/jit: Disable classic BPF JIT on ppc64le

 arch/powerpc/Kconfig                               |  2 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  1 -
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  1 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 16 ++++-
 arch/powerpc/include/asm/book3s/64/radix.h         | 15 ++++
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 14 ++++
 arch/powerpc/include/asm/book3s/pgalloc.h          |  5 --
 arch/powerpc/kernel/eeh_driver.c                   |  7 +-
 arch/powerpc/kernel/exceptions-64s.S               |  7 +-
 arch/powerpc/mm/hash_native_64.c                   |  8 +--
 arch/powerpc/mm/hash_utils_64.c                    | 14 ++--
 arch/powerpc/mm/mmu_context_book3s64.c             |  2 +-
 arch/powerpc/mm/pgtable-radix.c                    |  9 +--
 arch/powerpc/mm/tlb-radix.c                        | 84 ++++++++++++++++--=
----
 15 files changed, 137 insertions(+), 51 deletions(-)

--=-GzX7Rau4ichwkXu+glmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXbmUZAAoJEFHr6jzI4aWA0n8QAKX1osm07xUkzRyCY3qA2Oyy
ndRylzX7bLgc90OWBiZcfctIYYDDYWmeg1cS+NcLRZC7mxACRMqNnGs/GwXuP0xN
4WNmEysqVU6tHxNipYJaeFMI/e27yY9xQNdlxMi++rsTdoM6aELzbRGzAMXBLFq3
rYFPtmsC/mLBKlUknI7qCIxHddVlUbKBp3hFcmDFUKw42XjCQwyazBDeVl041WLK
0NSC/6zEFx7fO7AdtLQbnNARFm+CJZ8EOyWdzIZ8eL2gKjasIy39dy44xgiyUB6W
daDwtYqLQXAKHXQIAEd0ULW8MMfjYldBZST2Gs2Eg2cDXjCl3lk3G6w7e73xQ9I4
nsPrK8TgHMV9X48xBw/09sLDC+Brb+N6X20jWhRwZz0h3AfrdaL70pCN8C2Yyg3N
x2C0hTe+swyPphSHYIoW8fVG/yh1UIwVYQsmK7ah2BFc9mj+McLzvUhgjLxqbGgu
rsx0Uw72Dp4wBm6LVQPVqBAQHYbe17+RWCUufJPRS5WuPL1wypzmoFI66XBzmic/
Qu0u3/I/0ZBZzWjH8xrgPBUjDjsRCyL6nDmpH5aZSbrpvWV8qbbRNqnfLbO7TSXy
FMxocX7GjtoNYcGZVG6MbPDidKcXBTkJ2+2gTYcauFHprg6gr9AORp+Cd1npyvbU
oz3VEUDE+1VxqXrREVC5
=249p
-----END PGP SIGNATURE-----

--=-GzX7Rau4ichwkXu+glmk--

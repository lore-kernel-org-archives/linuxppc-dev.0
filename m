Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hlJs67J7zF31D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 21:32:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.18-5 tag
Date: Fri, 03 Aug 2018 21:32:44 +1000
Message-ID: <877el7hehv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 4.18:

The following changes since commit b03897cf318dfc47de33a7ecbc7655584266f034:

  powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (idle) (2018-07-18 20:40:17 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.18-5

for you to fetch changes up to cca19f0b684f4ed6aabf6ad07ae3e15e77bfd78a:

  powerpc/64s/radix: Fix missing global invalidations when removing copro (2018-08-01 23:23:41 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.18 #5

One fix for a regression in a recent TLB flush optimisation, which caused us to
incorrectly not send TLB invalidations to coprocessors.

Thanks to:
  Frederic Barrat, Nicholas Piggin, Vaibhav Jain.

- ------------------------------------------------------------------
Frederic Barrat (1):
      powerpc/64s/radix: Fix missing global invalidations when removing copro


 arch/powerpc/include/asm/mmu_context.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbZD0oAAoJEFHr6jzI4aWAcXgP/2H1bZ7IW+1iRkeBxLWerg+W
jjo6sMXYFE/yIWiDquE0hqTDF2yeUPORrTJHDFAarDQN4kNzfbiyW1x5rR45hUED
evbruA694+vzTIGH6bN/jiiuaazeKzX9SlweQN+eMZcO0R5m+BGPdz5mLlY/xvM+
9iRY89+ZmMzIK5yWFeXwFYhnqupOhQAKmCh3cGi9DDI3hfSfBOawAeYyx8H6y8WI
wd3bhl+PY6Yrx4Y6ZWnvWtNIY2QXSB9+rn0cOABPaQWasHhIYEFVpnT2DxRIM6ST
V9BNOj1PhvDcClnwaNE8Gus06CTqf2crOWVhOvYYwB0tMlvFnhFjexxwkhXQSmeT
kQKINYZ5eCyJhm1CmZ2CVv9KxPJESFilDr+CEHKXBq8mD7X1KUIvGyKmqZAOCgCQ
2ZBhgPoSs/lBoj7uBMgriMrnDI0VonUGNYSgT0XPiKIB0/vi5uYJBumwkvTuyDYk
2iIS29OnVv57xmF6QIvSp8jzmaDNxD+QP9Hrbqa7rInGiaGyYHAlfTqlm80ja7Jx
HBvYTW9PPKywYyTAxBpFc9TytuX4CvPMZsA1vo7Ow8nfVTNjtqGRl0VeXZ3fkW3E
QP8hfpgmkzIZeASpd1p7mSY0ki/5wad7Lb1wcqFJYE2/pT3Kd4oCjTbT7BFW70N6
hegdM5woDuk8lKFqao3V
=klUx
-----END PGP SIGNATURE-----

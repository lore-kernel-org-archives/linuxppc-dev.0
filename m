Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 634241A0AA2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:32:30 +1100 (AEDT)
Message-ID: <1445571149.27586.11.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.3-5 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: hegdevasant@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Date: Fri, 23 Oct 2015 14:32:29 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-tMqhRfFSuGnFQWxq5pN8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-tMqhRfFSuGnFQWxq5pN8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.3:

The following changes since commit abb39bc792aa8e9143e78a39ec13d7de1391f4b4=
:

  selftests/powerpc: Fix build failure of load_unaligned_zeropad test (2015=
-10-13 15:08:37 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.3-5

for you to fetch changes up to 8832317f662c06f5c06e638f57bfe89a71c9b266:

  powerpc/rtas: Validate rtas.entry before calling enter_rtas() (2015-10-22=
 11:03:25 +1100)

----------------------------------------------------------------
powerpc fixes for 4.3 #4

 - Revert "Use the POWER8 Micro Partition Prefetch Engine in KVM HV on POWE=
R8" from Paul
 - Handle irq_happened flag correctly in off-line loop from Paul
 - Validate rtas.entry before calling enter_rtas() from Vasant

----------------------------------------------------------------
Paul Mackerras (2):
      powerpc: Revert "Use the POWER8 Micro Partition Prefetch Engine in KV=
M HV on POWER8"
      powerpc/powernv: Handle irq_happened flag correctly in off-line loop

Vasant Hegde (1):
      powerpc/rtas: Validate rtas.entry before calling enter_rtas()

 arch/powerpc/include/asm/cache.h      |  7 -----
 arch/powerpc/include/asm/kvm_host.h   |  2 --
 arch/powerpc/include/asm/ppc-opcode.h | 17 -----------
 arch/powerpc/include/asm/reg.h        |  1 -
 arch/powerpc/kernel/rtas.c            |  3 ++
 arch/powerpc/kvm/book3s_hv.c          | 55 +------------------------------=
----
 arch/powerpc/platforms/powernv/smp.c  | 29 ++++++++++++++----
 7 files changed, 28 insertions(+), 86 deletions(-)

--=-tMqhRfFSuGnFQWxq5pN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWKapNAAoJEFHr6jzI4aWAzHsP/1W1X/Skl9j7YABkvdfzGdm/
xHXzY7Z4PkU/K721iWdbKmNoDUeVMYwfA/viGxtgPbzGebvvlUbruV2wzfTOaHbt
n49oqM5iuoTV0drDJKh8EBt/S+UcrWyzpE3bw09rdD8sgUmpHhLbS7IB38njPV/r
mX71cQDasjHw9oRTkBL0H2/PmUo6CKdiKwRWTlLfUbQ/XWtzdyV+au/zbKgE+PuH
Snp8TMGMFvYmzhp0MKt3Is1ywK1NLq004CMrIX/73vELZIpDSl+G3dNRrYF05zGB
hfYd0z4MHM1WxLpYW4GXRak60y5q3MVEDrJHS1Ngz85MiTI1Memcw8JA3n0mR8MZ
+ktqU3Gw6vaSxPhDfp95d7rz9luG8wLHZusiEvvmFt9L5n9GBb0gXnjr+T90jwmO
yzoxc5XWoOw8avQDcYYS406gTWIwlGS3uEUHwb/QXcbXWM0Y41PwC9ybdrwNKzqg
LN/4ALw9euJNDhDzfjcHZ9ehiggFmAEc7vFCyjv3B1Kb3JYq3dwh+1GtvJwZFcPX
MlPnz1HFAySePUCw/5gxZx6gF9uD9eqa89iFgV+4vQGAGUHYSJhJOqsXCtrDivmd
HZHWPiApNHGT7L8UNjhygYFyk+MCsLoFvgl5aAmi69XQjtChrU5la7gS/PazKG+p
xNyVPT2/+9M4UioGv+Tf
=WPvZ
-----END PGP SIGNATURE-----

--=-tMqhRfFSuGnFQWxq5pN8--

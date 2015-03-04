Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A0BC1A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 15:21:18 +1100 (AEDT)
Message-ID: <1425442860.9084.11.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.0-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 04 Mar 2015 15:21:00 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-Z0ls2Pa0r1I08AFhkb1I"
Mime-Version: 1.0
Cc: nacc@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, pc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Z0ls2Pa0r1I08AFhkb1I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some powerpc fixes for 4.0:

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539=
:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.0-2

for you to fetch changes up to 4ad04e5987115ece5fa8a0cf1dc72fcd4707e33e:

  powerpc/iommu: Remove IOMMU device references via bus notifier (2015-03-0=
4 13:19:33 +1100)

----------------------------------------------------------------
powerpc fixes for 4.0

- Fix for dynticks.
- Fix for smpboot bug.
- Fix for IOMMU group refcounting.
----------------------------------------------------------------

Michael Ellerman (1):
      powerpc/smp: Wait until secondaries are active & online

Nishanth Aravamudan (1):
      powerpc/iommu: Remove IOMMU device references via bus notifier

Paul Clarke (1):
      powerpc: Re-enable dynticks

 arch/powerpc/include/asm/iommu.h       |  6 ++++++
 arch/powerpc/include/asm/irq_work.h    |  9 +++++++++
 arch/powerpc/kernel/iommu.c            | 26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/smp.c              |  4 ++--
 arch/powerpc/platforms/powernv/pci.c   | 26 --------------------------
 arch/powerpc/platforms/pseries/iommu.c |  2 ++
 6 files changed, 45 insertions(+), 28 deletions(-)
 create mode 100644 arch/powerpc/include/asm/irq_work.h




--=-Z0ls2Pa0r1I08AFhkb1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJU9og9AAoJEFHr6jzI4aWA3QoP/34ZH3zrKNLvIWxMugGRsIt6
2G20lbIJUWhfDreOrlHfPwTtVh1x7MX90ehsINZYg/fIZ8Lzpjcdfw+eZxd2rl8E
Vx8Fv5LDAtKWg6dQ5GJaWQLdSjhZHCRWW7Sk7MP1dv5Z+PgXyBafAGXqMB2CZCm8
zWWlKeyGqxjiLt+V3FS8ozefoFDTElyPvSOeF1LvJFmznQKfgROcrvhVwUsHpSZE
Qs1m4VhVzW5LLDYeUJO0u+lXVAIu5GgC2q8OyemPdy3WhjOAfquHxg2Fq+1MBUWK
evWJotmeNQ26e6wAYFv0ILne6C7Q0dXxj5nRF80a+6wg9riDxPtwnHnfGd0NIFqA
m6sF6EL9vNBP3deemVY3O1M8YDsLSm8LszhKzADCmUHQ7NnRFIekKPG1qYlSj7dI
iRXdTZmoqMPcRj9x2fiUPlUtJ6Spo4Lo5+OtILyViNGty2kI5oBPerVXcyxtBK2g
4bMDfnKPmrbC7IpJGkav/+lar8a0zzj/Vx41dYJfLAK/EW7Ye65hf/0hZXGnKOhG
vZpzwtSHH0F2nUTtKuVl6fpQ3tHEwojo3nQd1o1XCpH6zJJFlaUmB4+mnHJs4fJp
5HV6xuMIioXLszzRjbmqwObXjPRGGRI5atLAIPikRwwvYNgp3q/hWvbzV+tT/Rap
HxYWx9bSHta9X3PgrgVX
=0Laf
-----END PGP SIGNATURE-----

--=-Z0ls2Pa0r1I08AFhkb1I--

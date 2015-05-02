Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E2C61A0D1C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 20:57:56 +1000 (AEST)
Message-ID: <1430564274.32317.1.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.1-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 02 May 2015 20:57:54 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-7KWTXNMnOB2VZLMICxTc"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, gwshan@linux.vnet.ibm.com, paulus@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 sam.bobroff@au1.ibm.com, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-7KWTXNMnOB2VZLMICxTc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.1:

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031=
:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.1-3

for you to fetch changes up to 0aab3747091db309b8a484cfd382a41644552aa3:

  powerpc/powernv: Restore non-volatile CRs after nap (2015-05-01 16:55:11 =
+1000)

----------------------------------------------------------------
powerpc fixes for 4.1 # 2

- Build fix for SMP=3Dn in book3s_xics.c
- Fix for Daniel's pci_controller_ops on powernv.
- Revert the TM syscall abort patch for now.
- CPU affinity fix from Nathan.
- Two EEH fixes from Gavin.
- Fix for CR corruption from Sam.
- Selftest build fix.

----------------------------------------------------------------
Daniel Axtens (1):
      powerpc/powernv: Fix early pci_controller_ops loading.

Gavin Shan (2):
      powerpc/eeh: Fix race condition in pcibios_set_pcie_reset_state()
      powerpc/eeh: Delay probing EEH device during hotplug

Michael Ellerman (3):
      powerpc/kvm: Fix SMP=3Dn build error in book3s_xics.c
      Revert "powerpc/tm: Abort syscalls in active transactions"
      selftests/powerpc: Fix the pmu install rule

Nathan Fontenot (1):
      powerpc/pseries: Correct cpu affinity for dlpar added cpus

Sam Bobroff (1):
      powerpc/powernv: Restore non-volatile CRs after nap

 Documentation/powerpc/transactional_memory.txt | 32 +++++++++++++---------=
----
 arch/powerpc/include/uapi/asm/tm.h             |  2 +-
 arch/powerpc/kernel/eeh.c                      | 11 ++++++++-
 arch/powerpc/kernel/entry_64.S                 | 19 ---------------
 arch/powerpc/kernel/idle_power7.S              |  2 ++
 arch/powerpc/kvm/book3s_xics.c                 |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c      |  2 +-
 arch/powerpc/platforms/pseries/dlpar.c         | 10 ++++----
 tools/testing/selftests/powerpc/pmu/Makefile   |  2 +-
 tools/testing/selftests/powerpc/tm/Makefile    |  2 +-
 10 files changed, 37 insertions(+), 47 deletions(-)



--=-7KWTXNMnOB2VZLMICxTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVRK2yAAoJEFHr6jzI4aWAL5kQAL3JpauRF+AddcR8Q5EYs4uw
dyWAMKc6O7f7PjJXkBU0jV4NlKbYUdYaH7h+rEQvX6pzjoyu3BtuANbTSBBlPBk4
zMqltVQQihbOBOFkomwGHNXYv28i8xsTFdMfUXZwpPuN+4XV6uP/kThGB3IfA3Yg
HfWT13DgntLJmWVmSNku1/T1SIMSXUfPhYk2H3Hhv+SM64TPDd7IE6EeQNYDqiGx
b3UltbH6XNwCAqPIVzK4Uz6cAP1LeOv1MrjDjCHcg8rDPMTjl9NrEDWvSnbta9ET
qLgFa9JOPPTQNRSAmneZGB/EzaSEHV4qmdxrMcQ6evr2e7CYqZAw2Dp/HIeGA0xI
4qKQxMGhY8cvSbAGJlaTslFzN38OK/9+RZS7Xr9NfodUilPzFWXDOogUzCgZlbOu
QyA0C81NGTJNE6kuhWPI/qCCSQLvJLklqLzLVCUbxRCsOSCjwgYoUkGdgwtmr5PQ
45QlbRAjDF3JbSkWkm/VeCr4aJc74Kr5B0AhdEAHrWtjLRTr7URLDQwE10xmxPqZ
BZW3zKTlKmqVGZgyqWFYGNqIa6Hmz6VB8TklLOoASWKl2zYROTwrCQhgTwE3AwDR
9MYaBnxF57u9OcADbA3qGIuzrEBGKTl4GfreZDp/9tCSZVuiNj259rgYttngD6Ya
0Dytd1xLf1ulUQyhGCuM
=MiXe
-----END PGP SIGNATURE-----

--=-7KWTXNMnOB2VZLMICxTc--

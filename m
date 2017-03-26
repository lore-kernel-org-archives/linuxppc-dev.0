Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrLbf2V14zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Mar 2017 13:25:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, ego@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, paulus@ozlabs.org,
 vaibhav@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-6 tag
Date: Sun, 26 Mar 2017 13:24:53 +1100
Message-ID: <87shm07p1m.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.11.

These are all pretty minor. The fix for idle wakeup would be a bad bug
but has not been observed in practice.

The update to the gcc-plugins docs was Cc'ed to Kees and Jon, Kees OK'ed
it going via powerpc and I didn't hear from Jon.

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-6

for you to fetch changes up to cc638a488a5205713b51eabd047be6ea641cc328:

  gcc-plugins: update architecture list in documentation (2017-03-21 22:20:05 +1100)

----------------------------------------------------------------
powerpc fixes for 4.11 #6

 - cxl: Route eeh events to all slices for pci_channel_io_perm_failure state
 - powerpc/64s: Fix idle wakeup potential to clobber registers
 - Revert "powerpc/64: Disable use of radix under a hypervisor"
 - gcc-plugins: update architecture list in documentation

Thanks to:
  Andrew Donnellan, Nicholas Piggin, Paul Mackerras, Vaibhav Jain.

----------------------------------------------------------------
Andrew Donnellan (1):
      gcc-plugins: update architecture list in documentation

Nicholas Piggin (1):
      powerpc/64s: Fix idle wakeup potential to clobber registers

Paul Mackerras (1):
      Revert "powerpc/64: Disable use of radix under a hypervisor"

Vaibhav Jain (1):
      cxl: Route eeh events to all slices for pci_channel_io_perm_failure state

 Documentation/gcc-plugins.txt     |  4 ++--
 arch/powerpc/kernel/idle_book3s.S | 20 +++++++++++++++++---
 arch/powerpc/mm/init_64.c         |  3 +--
 drivers/misc/cxl/pci.c            | 13 ++++++-------
 4 files changed, 26 insertions(+), 14 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY1yZ2AAoJEFHr6jzI4aWA2EwP/18kzEyAlut7yYpVMKD1o/K5
B1l3GUztHznZHw6nXHXdanjf7jZhBqnn2j2bGKqai9XRdgL2zvi6S2o3JQ6x2Go3
sHROQ8FKmB1MowPgEqkwEK+/tzIZQMCdZzsWIO9dyPbLXDhdsdpuw0+GuzXeKYff
SmRMvek7AQNRWkW04cVhqNPHaYvjxpDZ9SxmpBaIJLHMH43lgKNBOgFn99HqvRVo
/LdXxL9TNg1XG807ysnX5m84CYgZmc158le3U1XEIsqNbfOzOWd5tjrs3aw+zpfw
EMGexuw/2NZ6J7CoJ+02BAGBhPl0E4+aewGXbxwIs/2J73jMJG2FjvAE7R5743ra
b29HrPaayuGjPTpIyqoOgg6PGONRjANVKi1NVKKleiXP7ptiZaCpamsrO545+ZOi
/l08rDoxn92SXluVawJ0QsxRvFz+JibrewOmBSMVQvCqp8bu/uPHDhpNdF/2ZrvK
sclGNuNGioQBBtbtpG3xGbPrP0S7vleWN+DltDm5IhIwWicqE2kpyk7k4J9twnDH
30eUwssC2ZeqofbWrZJxHc2V7wT9iVASms4P6v0yoq0VfMZyQcjlOFo3njWWtKWN
fILrBobzYLV7Pmc32gqF8/dx1Dvtw7deGnrbU0OKTf7akMyGpaulcWtTy1sRb4hu
qXt4DedTqa8bMlLpvjPd
=9prG
-----END PGP SIGNATURE-----
--=-=-=--

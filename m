Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A0A81A002C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 14:42:04 +1000 (EST)
Message-ID: <1410410523.23087.3.camel@concordia>
Subject: [git pull] Please pull mpe.git for-linus branch (for powerpc)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Sep 2014 14:42:03 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-iwEjJ9J59fEMISQc3Y3t"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-iwEjJ9J59fEMISQc3Y3t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Hopefully you saw the message from Ben adding me as a co-maintainer for pow=
erpc:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3Dea668936b708029a0a11422ff834b651ac434c2d


Ben's travelling so this is my first attempt at a pull request.

There's nothing too exciting. The CONFIG_FHANDLE one is annoying, I know yo=
u
love defconfig changes. But we've had a couple of developers waste time
debugging boxes that wouldn't boot, only to realise it's just that systemd
needs CONFIG_FHANDLE and our defconfigs don't have it.

The new syscalls seem to be working, I've run the selftests that exist, and
also let trinity bash on them for a while.


The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd=
:

  Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git for-linus

for you to fetch changes up to 7d59deb50aafbdc01b52aed209d202d827261cb0:

  powerpc: Wire up sys_seccomp(), sys_getrandom() and sys_memfd_create() (2=
014-09-09 19:02:47 +1000)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc/perf: Fix ABIv2 kernel backtraces

Cyril Bur (1):
      powerpc: Make CONFIG_FHANDLE=3Dy for all 64 bit powerpc defconfigs

Li Zhong (1):
      powerpc: use machine_subsys_initcall() for opal_hmi_handler_init()

Pranith Kumar (1):
      powerpc: Wire up sys_seccomp(), sys_getrandom() and sys_memfd_create(=
)

Thomas Falcon (1):
      powerpc/pseries: Fix endian issues in memory hotplug

 arch/powerpc/configs/cell_defconfig             |  1 +
 arch/powerpc/configs/celleb_defconfig           |  1 +
 arch/powerpc/configs/corenet64_smp_defconfig    |  1 +
 arch/powerpc/configs/g5_defconfig               |  1 +
 arch/powerpc/configs/maple_defconfig            |  1 +
 arch/powerpc/configs/pasemi_defconfig           |  1 +
 arch/powerpc/configs/ppc64_defconfig            |  1 +
 arch/powerpc/configs/ppc64e_defconfig           |  1 +
 arch/powerpc/configs/ps3_defconfig              |  1 +
 arch/powerpc/configs/pseries_defconfig          |  1 +
 arch/powerpc/configs/pseries_le_defconfig       |  1 +
 arch/powerpc/include/asm/ptrace.h               |  7 +++++++
 arch/powerpc/include/asm/systbl.h               |  3 +++
 arch/powerpc/include/asm/unistd.h               |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h          |  3 +++
 arch/powerpc/perf/callchain.c                   |  2 +-
 arch/powerpc/platforms/powernv/opal-hmi.c       |  3 ++-
 arch/powerpc/platforms/pseries/hotplug-memory.c | 36 +++++++++++++++++++--=
---------------
 18 files changed, 47 insertions(+), 20 deletions(-)




--=-iwEjJ9J59fEMISQc3Y3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJUESgbAAoJEFHr6jzI4aWAyGwP/jjp4Y9XG89OEnASp4TfD6vf
0VbsK5Yo3HAn6Ci4H7HLWLsO3Hc9FbtTC84K6ZbyddWvDMGpkh6Xi0e+2pSE/ZKS
RJ8NdVziKfUdTx7wi3lsbh5RB5t8Qs8CkALL27WuWtSMYUs/4m9jeRRUq3pm3lIR
IdXtu0Gcv+zugo9S88sMKidyqtP+ITZLkjrSFphKGhnq4T2nLJb7pAEcpwISSMxi
+gtbVHRWGQ97Le8bADvq7NMLTe17fas45kOFaJ8RN1CGlV0cY4+IfEPOi5VsOhhS
4Oji7peR/DBx0bbeTtOxJZL8m0GPQ9/0is3L+/8MUiVlU8GvCNSc4LU7UGcP/Iqf
ZdeUGKKwNGRqaClUcdpwNKvtpQXlczVsOWBEPtIMuipdblsSQWDinoQPx4xhkay+
f7gZkzeCjqToGLzbtz6GRdyVqDyGPAC73uAhX1phtoHDve5iN+dbR4BE0o2xaR5I
TJKlvE2dDL/KExeBjzbUKXqeqAnNrrw4iE5M788mwmemafVE9mgJ0GILp4v7xxUv
ap5dQpXAbx/plARyNl6w/d5tINvUCd8I07Q4W6vqtXCearaNvtFT5jRI2iTBuj20
CplO7wY6XcbhPiIQSk0n+8mOWV7SXFVEA2xPlpoaYZUGNnk2mrOE+OpQG/nO3mte
cXQmaHLDr7X0Yvo+ua6d
=yc6X
-----END PGP SIGNATURE-----

--=-iwEjJ9J59fEMISQc3Y3t--

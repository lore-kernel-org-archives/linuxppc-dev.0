Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Pd2HtKzDx69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:09:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anju@linux.vnet.ibm.com, benh@kernel.crashing.org, clg@kaod.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lvivier@redhat.com, ravi.bangoria@linux.vnet.ibm.com, paulus@samba.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-5 tag
Date: Fri, 22 Dec 2017 22:09:38 +1100
Message-ID: <873743ow7h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.15.

This is all fairly boring, except that there's two KVM fixes that you'd
normally get via Paul's kvm-ppc tree. He's away so I picked them up. I
was waiting to see if he would apply them, which is why they have only
been in my tree since today. But they were on the list for a while and
have been tested on the relevant hardware.

cheers


The following changes since commit d8104182087319fd753d6d8e0afcd95d84c2aa2f:

  powerpc/xmon: Don't print hashed pointers in xmon (2017-12-07 00:27:01 +1=
100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.15-5

for you to fetch changes up to 7333b5aca412d6ad02667b5a513485838a91b136:

  KVM: PPC: Book3S HV: Fix pending_pri value in kvmppc_xive_get_icp() (2017=
-12-22 15:36:24 +1100)

=2D---------------------------------------------------------------
powerpc fixes for 4.15 #5

Of note is two fixes for KVM XIVE (Power9 interrupt controller). These would
normally go via the KVM tree but Paul is away so I've picked them up.

Other than that, two fixes for error handling in the IMC driver, and one fo=
r a
potential oops in the BHRB code if the hardware records a branch address th=
at
has subsequently been unmapped, and finally a s/%p/%px/ in our oops code.

Thanks to:
  Anju T Sudhakar, C=C3=A9dric Le Goater, Laurent Vivier, Madhavan Srinivas=
an, Naveen
  N. Rao, Ravi Bangoria.

=2D---------------------------------------------------------------
Anju T Sudhakar (2):
      powerpc/perf/imc: Fix nest-imc cpuhotplug callback failure
      powerpc/perf: Fix kfree memory allocated for nest pmus

C=C3=A9dric Le Goater (1):
      KVM: PPC: Book3S: fix XIVE migration of pending interrupts

Laurent Vivier (1):
      KVM: PPC: Book3S HV: Fix pending_pri value in kvmppc_xive_get_icp()

Michael Ellerman (1):
      powerpc/kernel: Print actual address of regs when oopsing

Ravi Bangoria (1):
      powerpc/perf: Dereference BHRB entries safely

 arch/powerpc/kernel/process.c   |  2 +-
 arch/powerpc/kvm/book3s_xive.c  |  7 ++++---
 arch/powerpc/perf/core-book3s.c |  8 ++++++--
 arch/powerpc/perf/imc-pmu.c     | 17 ++++++++++++++++-
 4 files changed, 27 insertions(+), 7 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaPOfzAAoJEFHr6jzI4aWA2VAP/3LNLSY2ZNz5kWWpB4rbOmgH
imShGRdi6B+8UkyLS6bvGPSdWA95cSlCkPpdTBiO9b6pk9aYhuqhk3Q2WYBN9eTc
j2aZjmGMa9WpPpPBvLKyKmxsLOnDFT2XH6kejptqdN1Q/jjPM50pn/GXPbFLIC6a
HDSJfLDs+GqtgsA39B4GaszAOIv0xrm6kcULl1EjrMs+oZR2+UJ01atXkHI35GXP
9VI/Aak50RXw9Yx4/8F9OZNYpNXQrKv+BRRNVFrKQXl/qIguDUhohgeNNcBIugfD
wGX9FntChetulaGqZxJrRVqcqy8we3btaFl9lt8aIG7P6C+Z/6q3UVrl9o70FmqM
2yqZ2Y0WaThGz2hkGVeeWdlEAqLiwGyhBL6wYeQaaY7skXl6FE50r9Y5B3lehLoB
TWBg9A8O25Y+MDrS35QIphWzgDaJmqAQF8+FDUpudi3PvFKYp/TT1UXAUGiGXj2Y
pOyuirQjP5vPHg9wXIO4iLkoF8tK1nGSXtYgcGgJcE2Mbnp3sPEgPkEtanwIyzcw
jHqTg8aW0qlEFDK/JthdupssyQgilAHDiNE0/kXsPGFq3DF6L0SlNiBxICoXcysg
kO91Sy0ugziKS7Vbidofvex3vawSvM1SVRChIe7C3GE6TqdwAXIxaenBniIBphnP
aSNiRUuuHXwvI0AVbBKv
=zMPa
-----END PGP SIGNATURE-----
--=-=-=--

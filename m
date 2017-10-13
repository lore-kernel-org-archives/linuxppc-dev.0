Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yD6WV1p8gzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 23:30:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anju@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sandipan@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.14-5 tag
Date: Fri, 13 Oct 2017 23:30:44 +1100
Message-ID: <878tgftekr.fsf@concordia.ellerman.id.au>
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

Please pull a few more powerpc fixes for 4.14:

The following changes since commit 53ecde0b9126ff140abe3aefd7f0ec64d6fa36b0:

  powerpc/powernv: Increase memory block size to 1GB on radix (2017-10-06 15:50:45 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.14-5

for you to fetch changes up to 0d8ba16278ec30a262d931875018abee332f926f:

  powerpc/perf: Fix IMC initialization crash (2017-10-13 20:08:40 +1100)

----------------------------------------------------------------
powerpc fixes for 4.14 #5

A fix for a bad bug (written by me) in our livepatch handler. Removal of an
over-zealous lockdep_assert_cpus_held() in our topology code. A fix to the
recently added emulation of cntlz[wd]. And three small fixes to the recently
added IMC PMU driver.

Thanks to:
  Anju T Sudhakar, Balbir Singh, Kamalesh Babulal, Naveen N. Rao, Sandipan Das,
  Santosh Sivaraj, Thiago Jung Bauermann.

----------------------------------------------------------------
Anju T Sudhakar (3):
      powerpc/perf: Fix for core/nest imc call trace on cpuhotplug
      powerpc/perf: Add ___GFP_NOWARN flag to alloc_pages_node()
      powerpc/perf: Fix IMC initialization crash

Kamalesh Babulal (1):
      powerpc/livepatch: Fix livepatch stack access

Sandipan Das (1):
      powerpc/lib/sstep: Fix count leading zeros instructions

Thiago Jung Bauermann (1):
      powerpc: Don't call lockdep_assert_cpus_held() from arch_update_cpu_topology()

 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 45 +++++++++-----------------
 arch/powerpc/lib/sstep.c                       |  6 ++--
 arch/powerpc/mm/numa.c                         |  1 -
 arch/powerpc/perf/imc-pmu.c                    | 39 +++++++++++++++++++---
 4 files changed, 53 insertions(+), 38 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZ4LH0AAoJEFHr6jzI4aWAMa0P/1yr6ANq99DkJBQDofezW2/3
Jq2uimm70+QWs5A2v+qQOmrzbRmXJ9T5qDtDN+3i/6cF4Qm7/JgoR5lbo6XdybZE
AIEn+iYAMBJgxoSqTJ0Do9PlRz/8gFKA4fIr2I75UReKV6s3V1Wfx88kRSYHK9w2
/oas+d2H0sEJ//0CTfpQLBqd6tze+VkEXXbp35zcOh3y6Ap6iNNWEOpB3S3jqx9M
rN0gcX4Vlknpjhr4VBoCIjglr2mLB5inMYJizAJebPqGLZkZEDkvpOFB/8C9HcDF
7PgucftFi7+k8iNne/zfLOc+AxT2zWJE7rdS5NsInmHr0HDhEyFa2O+2DUigzO5X
s+2DlybqFTA/0gYpPKqrSUoTQq96lNnr8OP+oM9gjoWNQq8gNIIBfA4q3LGPMl+0
WIjI+ajhDC40o9qMMifFrOTSinf6qMiUBFrmpHZ/a7eawaqehkuL5X0uwJiDgtFk
7kEnmKdkR/9o0woPQvl62ZZSPqevjm0qvKTE2wHJ1lBSFP3WTC2fBAAABzJ1t4dw
vJZrmNvkG8E1Wt1DiyTQvenqeidVx2VWo+LBoWACSg04GTdzFFAbNudo0hYfYH/6
mmmi3fVyL7B3yFITEr4xMr9t/tVjr3NXvyeHFkLiSp8wCyG5liXDoXw/QlQdHzmF
k9mqVv48pxZM1PVMhxno
=YNsT
-----END PGP SIGNATURE-----
--=-=-=--

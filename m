Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x89zN66F4zDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 21:52:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anton@samba.org, benh@kernel.crashing.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com,
 oohall@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-2 tag
Date: Fri, 14 Jul 2017 21:52:21 +1000
Message-ID: <87lgnrnslm.fsf@concordia.ellerman.id.au>
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

Please pull the first set of powerpc fixes for 4.13:

The following changes since commit af3c8d98508d37541d4bf57f13a984a7f73a328c:

  Merge tag 'drm-for-v4.13' of git://people.freedesktop.org/~airlied/linux (2017-07-09 18:48:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-2

for you to fetch changes up to 01e6a61aceb82e13bec29502a8eb70d9574f97ad:

  powerpc/64: Fix atomic64_inc_not_zero() to return an int (2017-07-12 21:49:55 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #2

Nothing that really stands out, just a bunch of fixes that have come in in the
last couple of weeks.

None of these are actually fixes for code that is new in 4.13. It's roughly half
older bugs, with fixes going to stable, and half fixes/updates for Power9.

Thanks to:
  Aneesh Kumar K.V, Anton Blanchard, Balbir Singh, Benjamin Herrenschmidt,
  Madhavan Srinivasan, Michael Neuling, Nicholas Piggin, Oliver O'Halloran.

----------------------------------------------------------------
Anton Blanchard (3):
      powerpc/perf: Add POWER9 alternate PM_RUN_CYC and PM_RUN_INST_CMPL events
      powerpc: Fix emulation of mcrf in emulate_step()
      powerpc: Fix emulation of mfocrf in emulate_step()

Balbir Singh (1):
      powerpc/kexec: Fix radix to hash kexec due to IAMR/AMOR

Benjamin Herrenschmidt (3):
      powerpc/powernv: Tell OPAL about our MMU mode on POWER9
      powerpc/mm/radix: Properly clear process table entry
      powerpc/mm/radix: Synchronize updates to the process table

Madhavan Srinivasan (1):
      powerpc/perf: Fix SDAR_MODE value for continous sampling on Power9

Michael Ellerman (1):
      powerpc/64: Fix atomic64_inc_not_zero() to return an int

Nicholas Piggin (1):
      powerpc/powernv: Fix local TLB flush for boot and MCE on POWER9

Oliver O'Halloran (1):
      powerpc/asm: Mark cr0 as clobbered in mftb()

 arch/powerpc/include/asm/atomic.h      |  4 +--
 arch/powerpc/include/asm/opal-api.h    |  9 ++++++
 arch/powerpc/include/asm/reg.h         |  2 +-
 arch/powerpc/kernel/cpu_setup_power.S  | 13 ++++++--
 arch/powerpc/kernel/dt_cpu_ftrs.c      | 16 ++--------
 arch/powerpc/kernel/mce_power.c        | 56 +++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/misc_64.S          | 12 ++++++++
 arch/powerpc/lib/sstep.c               | 19 ++++++++++--
 arch/powerpc/mm/mmu_context_book3s64.c | 20 ++++++++++--
 arch/powerpc/perf/isa207-common.c      |  6 ++--
 arch/powerpc/perf/power9-events-list.h |  4 +++
 arch/powerpc/perf/power9-pmu.c         |  2 ++
 arch/powerpc/platforms/powernv/opal.c  | 19 ++++++++++--
 arch/powerpc/platforms/powernv/setup.c | 11 ++++++-
 14 files changed, 162 insertions(+), 31 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZaLB2AAoJEFHr6jzI4aWAi9oQAIvnD3ljjGG1/Zt+iAk4AqL3
AbsJCBCk3MuQd7Z90nDWkfebdnYFu8eYuc6oN/UBSZqEWwttS3Ualr81NOj0OCgO
e3RI+B+I7vZfzPEY4rwxBrDBjQUaaJtlQ8X7ftAtbmU54oBDBgsLz9oShbCiEJPg
Iv12XtWFmXuVcM9yQGwk27pZ8kvzN+CLy+7l0nb1y7qzkhbNhPvRBE9t6FdLZvHQ
0Wq7kZ0Ro90UYYWMdcjf6x57Juq+gZDhN0cEx8D0qECj7ql5kxOok5Q5P65mzY6O
/bVQ07uvIqrlvpMF5XU4pvKGkOgiFdW+YZ1LNHxrbCVuBQZPjS1WwXV4Zmu6YaiY
ppuSCldUMIZGg9Q2YyV85BNRuIYLTIDQvTqABvdjLbbhY0HomIKgpHdj9OnM3PpT
d9OqKtfenXC5bQrUNaWmyWIjnV9eabmKc5JpFHxfSFJrLNTj0tDe4L9memAwuRyc
JNCBqBtWja2zpN1+o+ZStaC9zLlHVkhCZkZeAplxCp9WXNCNeIaT0vVUrDbb16C5
bjqoG/VwepsiaHgpyAwDHjfd7XST6rY7VMtWnk21eW3mlPE3GgEhY+ghpZ+Qivc9
u/urtTGTgPNBVEmpzia0K44NuyMvoBDXlPz4otb6uUhY4NB5vvH0VUQZ+ZomRyja
DXLth9Mo6aBkmkIdVLLk
=sFUd
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E1101A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 20:31:31 +1100 (AEDT)
Message-ID: <1454059885.7560.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.5-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: amodra@gmail.com, aneesh.kumar@linux.vnet.ibm.com,
 chandan@linux.vnet.ibm.com, dan.j.williams@intel.com,
 gwshan@linux.vnet.ibm.com,  hegdevasant@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 29 Jan 2016 20:31:25 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-rY13Dq5ug+0vEAvsei4P"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-rY13Dq5ug+0vEAvsei4P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc fixes for 4.5:

The following changes since commit 9fa686068a32ddf256df03982b3e3967c18654a8=
:

  Merge tag 'dmaengine-fix-4.5-rc1' of git://git.infradead.org/users/vkoul/=
slave-dma (2016-01-20 10:15:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.5-2

for you to fetch changes up to 2d19fc639516dc7b4184450b315c931d38549e61:

  powerpc/mm: Fixup _HPAGE_CHG_MASK (2016-01-28 23:49:43 +1100)

----------------------------------------------------------------
powerpc fixes for 4.5

 - Wire up copy_file_range() syscall from Chandan Rajendra
 - Simplify module TOC handling from Alan Modra
 - Remove newly added extra definition of pmd_dirty from Stephen Rothwell
 - Allow user space to map rtas_rmo_buf from Vasant Hegde
 - Fix PE location code from Gavin Shan
 - Remove PPMU_HAS_SSLOT flag for Power8 from Madhavan Srinivasan
 - Fixup _HPAGE_CHG_MASK from Aneesh Kumar K.V

----------------------------------------------------------------
Alan Modra (1):
      powerpc: Simplify module TOC handling

Aneesh Kumar K.V (1):
      powerpc/mm: Fixup _HPAGE_CHG_MASK

Chandan Rajendra (1):
      powerpc: Wire up copy_file_range() syscall

Gavin Shan (1):
      powerpc/eeh: Fix PE location code

Madhavan Srinivasan (1):
      powerpc/perf: Remove PPMU_HAS_SSLOT flag for Power8

Stephen Rothwell (1):
      powerpc: Remove newly added extra definition of pmd_dirty

Vasant Hegde (1):
      powerpc/mm: Allow user space to map rtas_rmo_buf

 arch/powerpc/include/asm/book3s/64/hash.h    |  4 +++-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/powerpc/include/asm/systbl.h            |  1 +
 arch/powerpc/include/asm/unistd.h            |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h       |  1 +
 arch/powerpc/kernel/eeh_pe.c                 | 33 +++++++++++++-----------=
----
 arch/powerpc/kernel/misc_64.S                | 28 -----------------------
 arch/powerpc/kernel/module_64.c              | 12 +++++++---
 arch/powerpc/mm/mem.c                        |  4 ++--
 arch/powerpc/perf/power8-pmu.c               |  2 +-
 scripts/mod/modpost.c                        |  3 ++-
 11 files changed, 35 insertions(+), 56 deletions(-)

--=-rY13Dq5ug+0vEAvsei4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWqzFtAAoJEFHr6jzI4aWAub8P/i4BMUyrvF0H4+sv3Z8lKpVH
PqkVkBTjdxbRfMByE08cFHKYBNbRz7MwZNaF7DW/8XQBxEtSW/g/fcqVfGNxehXr
D4egYwSYa8QTemkJPcdiEcBDciLoo7/I95LPB2LMm7z9Y5klpej/T7nVLkwmkOaC
Z3lsno15OUildwB+YjdFt2HGYOWDtHo5ssJTLeMu5h6Isit+SF2uTRBKBgQ31cmX
x90DJPkfJvGoi4cYAfcQADgjWgr2iCzk4BjCUGnxwH111QFGahTEc5lXVPeCrFHF
5KeUts+svDX3arMxZs4cyvrI84Usor8RtSkAPGMwoljt6smxVsrB+I/ZkShPQORV
tlWFw+mVSAYv5slauGeYZAPIyAig0cT2A5DBwxPWxAq7+RZlUEfESqfDReF1yQ79
/IsdZJetUH3LwKRSs7M9EoNFIMMEVTGaCbjR5JgFwbxglP/UUKZZuqGDy8vPWuby
jgM4syJip2SvFPf3aC8pm3j+icz22Dju/AJEy97ydnQYvE0xpHSWxX3wVWwT3PB9
5QVFlAJYkZ79Ix9aQQFpn96IuklyZ65wHTG8zJMI+vjaHgPUPgc1japmhDxsFSm1
ks8qtyUECaLDK7z7tZKiM0tc6lHS7euMuCoBoFpArv1d3VbJbtlHPsVWRRSzJzc3
pE45LeLRmWwVp11j2w7y
=JiDc
-----END PGP SIGNATURE-----

--=-rY13Dq5ug+0vEAvsei4P--

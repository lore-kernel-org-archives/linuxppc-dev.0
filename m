Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0CC01A0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 19:52:32 +1100 (AEDT)
Message-ID: <1414572739.5922.4.camel@concordia>
Subject: [git pull] Please pull mpe.git for-linus branch (for powerpc)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Oct 2014 19:52:19 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-7BJVI6lbi5ZMcCbXTFRE"
Mime-Version: 1.0
Cc: nacc@linux.vnet.ibm.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 jk@ozlabs.org, imunsie@au1.ibm.com, bobby.prani@gmail.com, ddstreet@ieee.org,
 aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-7BJVI6lbi5ZMcCbXTFRE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are some updates for powerpc.

There's some bug fixes or cleanups to facilitate fixes, a MAINTAINERS updat=
e,
and a new syscall (bpf).

cheers


The following changes since commit c3351dfabf5c78fb5ddc79d0f7b65ebd9e441337=
:

  Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/=
nab/target-pending (2014-10-21 13:06:38 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git for-linus

for you to fetch changes up to 2c0a33f9861d38631245f7ef434ecad3413324fb:

  powerpc/numa: ensure per-cpu NUMA mappings are correct on topology update=
 (2014-10-29 09:41:22 +1100)

----------------------------------------------------------------
Aneesh Kumar K.V (2):
      powerpc/mm: Fix build error with hugetlfs disabled
      powerpc/mm: Remove redundant #if case

Dan Streetman (1):
      MAINTAINERS: nx-842 driver maintainer change

Ian Munsie (4):
      cxl: Disable secondary hash in segment table
      cxl: Refactor cxl_load_segment() and find_free_sste()
      powerpc/mm: Use appropriate ESID mask in copro_calculate_slb()
      cxl: Fix PSL error due to duplicate segment table entries

Jeremy Kerr (1):
      powernv: Use _GLOBAL_TOC for opal wrappers

Michael Ellerman (1):
      Revert "powerpc/powernv: Fix endian bug in LPC bus debugfs accessors"

Nishanth Aravamudan (2):
      powerpc/numa: use cached value of update->cpu in update_cpu_topology
      powerpc/numa: ensure per-cpu NUMA mappings are correct on topology up=
date

Pranith Kumar (1):
      powerpc: Wire up sys_bpf() syscall

 MAINTAINERS                                    |  2 +-
 arch/powerpc/include/asm/hugetlb.h             |  2 +-
 arch/powerpc/include/asm/systbl.h              |  1 +
 arch/powerpc/include/asm/unistd.h              |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h         |  1 +
 arch/powerpc/mm/copro_fault.c                  |  3 +-
 arch/powerpc/mm/numa.c                         |  7 ++-
 arch/powerpc/mm/slice.c                        |  3 +-
 arch/powerpc/platforms/powernv/opal-lpc.c      |  4 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |  2 +-
 drivers/misc/cxl/fault.c                       | 74 ++++++++++++++--------=
----
 drivers/misc/cxl/native.c                      |  4 +-
 12 files changed, 56 insertions(+), 49 deletions(-)



--=-7BJVI6lbi5ZMcCbXTFRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJUUKrPAAoJEFHr6jzI4aWAkNoP/RDC4OVOXUtYxSMCxaUp/UCe
NIHeQQG88sBF2N/27ZyvphiyOcpjvfp3kHllmC+f6QivsfGBAgohid5pWenCIWb2
QauJzQ/5KIMGlQcCmmH0oM9OJZQ0by9KoXzgBQJpfd0qToNQFw1BdHzkLQ/nx3gd
k5hQpsZmXxE2TLAw55eXUtMh2lRCbyMUi8TikzqDxRsxIq5lmZEzW2KFPyKpRKPr
04P1A3QX2WTwo0UDE0y1tmlrsPj+QQb8jkdzAW2/7I3PgDQPe5CZ4NnLIt/nRmPP
q/wzQArTbd0XeatFqWc7DrK30ih0MvPQn++lLw4NckkJ5n56wJOjD6BNdpevaL9p
0J5UtL9fvdw6dG8s5IimnkiTAq+BmERE1SfH72X8L/lXNhnL8+zNwwW+EH4lDQRH
Vwc4aXDUC/CVvSzVuUQ+QmLqvzq+2+u80mkx26Xl8Ks6PuYE9DQTslE+qc0ZoQCo
VB+JzMDUvHtA9IGX6CcP8dr2Npz9iUKHU1KECBmi10J7zLEh3TdwKKH6p5jw2Xml
NFunot6xtmq/Oksvbe8WElMBlyRYl94q+bJDNy4wG3CVjGlF6WYXtNz3Hm5lH2OW
KlVqTl1SsRLBiZ5yROzQL88CZYWtfBFljTzXxZPgU9w9Jrs3vMncfpjSdbBgJphB
TX0YbqDXGftPBZUQuSVB
=Rykg
-----END PGP SIGNATURE-----

--=-7BJVI6lbi5ZMcCbXTFRE--

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvYzp24NLzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 09:09:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mhiramat@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com,
 ravi.bangoria@linux.vnet.ibm.com, rostedt@goodmis.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-7 tag
Date: Sat, 24 Jun 2017 09:09:08 +1000
Message-ID: <87injmpai3.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.12. Most of these actually came in
last week but got held up for some more testing.

The following changes since commit a093c92dc7f96a15de98ec8cfe38e6f7610a5969:

  powerpc/debug: Add missing warn flag to WARN_ON's non-builtin path (2017-06-16 16:10:37 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-7

for you to fetch changes up to 34f19ff1b5a0d11e46df479623d6936460105c9f:

  powerpc/64: Initialise thread_info for emergency stacks (2017-06-23 13:25:38 +1000)

----------------------------------------------------------------
powerpc fixes for 4.12 #7

 - three fixes for kprobes/ftrace/livepatch interactions.

 - properly handle data breakpoints when using the Radix MMU.

 - fix for perf sampling of registers during call_usermodehelper().

 - properly initialise the thread_info on our emergency stacks.

 - add an explicit flush when doing TLB invalidations for a process
   using NPU2.

Thanks to:
  Alistair Popple, Naveen N. Rao, Nicholas Piggin, Ravi Bangoria,
  Masami Hiramatsu.

----------------------------------------------------------------
Alistair Popple (1):
      powerpc/powernv/npu-dma: Add explicit flush when sending an ATSD

Naveen N. Rao (4):
      powerpc/kprobes: Pause function_graph tracing during jprobes handling
      powerpc/ftrace: Pass the correct stack pointer for DYNAMIC_FTRACE_WITH_REGS
      powerpc/kprobes: Skip livepatch_handler() for jprobes
      powerpc/64s: Handle data breakpoints in Radix mode

Nicholas Piggin (1):
      powerpc/64: Initialise thread_info for emergency stacks

Ravi Bangoria (1):
      powerpc/perf: Fix oops when kthread execs user process

 arch/powerpc/include/asm/kprobes.h             |  1 +
 arch/powerpc/kernel/exceptions-64s.S           | 11 +--
 arch/powerpc/kernel/kprobes.c                  | 17 +++++
 arch/powerpc/kernel/setup_64.c                 | 31 ++++++++-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 59 ++++++++++++----
 arch/powerpc/perf/perf_regs.c                  |  3 +-
 arch/powerpc/platforms/powernv/npu-dma.c       | 94 ++++++++++++++++++--------
 7 files changed, 166 insertions(+), 50 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZTZ+UAAoJEFHr6jzI4aWAw3QP/3ZwTXsGLcksVyGlsVVY2S3n
BS+sIzm1ptEKVteRo6uAkNUQp+dfL9Clw6WG/24LiYhNASMd01H99wrNM95BiOZS
w743GJhTNpaTZeJls/T3Ulwiq8koisx4wDoybsJYkW1ifZfZkgEtRqHuzpch34zD
abIGLKTQTMcRmBxrMnR0ANOCd00WHVnBeIVQAj2679lj95PDMEXylqIS69r/pKLU
43cdc7JHAAjbUE3ZQDiPY0DwHr+fTsxtGDymYGwIMWgnPv6FNzDEOyGZPhWjTAQM
6NDqj1wCJ9ymefq9CPK6K4NiRPi6fuQYLEtRJOJqxmMlUpTW0+MJVcsEAbo7+ML1
DOMIZPBSC5+7lKW/o6naKEkiOFnA3FosKD/h30SvtsTijcStLNoaxCdObs3QkqkB
+/SQGNP/z0j3Jzvx9KS81H10F5Gn7xUrU18BGBFxJJp8t8i81BMwvnZUwFCLErQN
eO6fl9IYsK2vIvJESAKm+R8aBt4y6uQ2dn3vl2SNSwQlBy0+Ptarow15KpzLz/rX
4nrQ58ugVeZAbEV2LxfDfMTQJXGtrIM6Qyk55yWj7OYvU5X1KRrxSAdVOSS4fjmZ
hUW3w6zMc/cyj6RFlK+2odjS5azBSfqU9aNZAKoXhproTGrCoO40q+lt9nQ1JPVT
i+Xi7yveeZwBA9/mIuii
=HEG0
-----END PGP SIGNATURE-----
--=-=-=--

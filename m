Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3B9A1B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 15:20:30 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CA88DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 15:20:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19082.14648.105530.977284@cargo.ozlabs.ibm.com>
Date: Tue, 18 Aug 2009 15:16:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull my perfcounters.git tree
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

The following changes since commit 64f1607ffbbc772685733ea63e6f7f4183df1b16:
  Linus Torvalds (1):
        Linux 2.6.31-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perfcounters.git master

Please pull them into your powerpc-next branch.  I'll also ask Ingo
Molnar to pull them into the tip tree.

Thanks,
Paul.

Paul Mackerras (3):
      powerpc/32: Always order writes to halves of 64-bit PTEs
      powerpc: Allow perf_counters to access user memory at interrupt time
      perf_counter: powerpc: Add callchain support

 arch/powerpc/include/asm/pgtable.h   |    6 +-
 arch/powerpc/kernel/Makefile         |    2 +-
 arch/powerpc/kernel/asm-offsets.c    |    2 +
 arch/powerpc/kernel/exceptions-64s.S |   19 ++
 arch/powerpc/kernel/perf_callchain.c |  527 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/slb.c                |   37 ++-
 arch/powerpc/mm/stab.c               |   11 +-
 7 files changed, 588 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/kernel/perf_callchain.c

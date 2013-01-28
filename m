Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C9D062C0099
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2013 10:42:12 +1100 (EST)
Message-ID: <1359416520.18955.12.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Jan 2013 10:42:00 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Whenever you have a chance between two dives, you might want to consider
pulling my merge branch to pickup a few fixes for 3.8 that have been
accumulating for the last couple of weeks (I was myself travelling
then on vacation). Nothing major, just a handful of powerpc bug fixes
that I consider worth getting in before 3.8 goes final.

Cheers,
Ben.

The following changes since commit 45e72af09faa7dad5d8539ebac0fe317ae88318b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-3.0-fixes (2013-01-28 11:53:49 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git 

for you to fetch changes up to 689dfa894c57842a05bf6dc9f97e6bb71ec5f386:

  powerpc: Max next_tb to prevent from replaying timer interrupt (2013-01-29 10:18:16 +1100)

----------------------------------------------------------------
Carl E. Love (1):
      powerpc/oprofile: Fix error in oprofile power7_marked_instr_event() function

Cong Ding (1):
      powerpc: kernel/kgdb.c: Fix memory leakage

Li Zhong (1):
      powerpc: Fix MAX_STACK_TRACE_ENTRIES too low warning for ppc32

Steven Rostedt (1):
      powerpc/pasemi: Fix crash on reboot

Tiejun Chen (2):
      powerpc/book3e: Disable interrupt after preempt_schedule_irq
      powerpc: Max next_tb to prevent from replaying timer interrupt

 arch/powerpc/kernel/entry_32.S          |    2 ++
 arch/powerpc/kernel/entry_64.S          |   13 +++++++++++++
 arch/powerpc/kernel/kgdb.c              |    5 +++--
 arch/powerpc/kernel/time.c              |    9 +++++++--
 arch/powerpc/oprofile/op_model_power4.c |    2 +-
 arch/powerpc/platforms/pasemi/cpufreq.c |    7 +++++++
 6 files changed, 33 insertions(+), 5 deletions(-)

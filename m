Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18233.34406.990766.284315@cargo.ozlabs.ibm.com>
Date: Tue, 13 Nov 2007 22:11:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a few more bug-fixes for powerpc.  (OK, two of the commits are
cosmetic printk changes and one is a workaround for a hardware
erratum, but they are all reasonable 2.6.24 material.)

Thanks,
Paul.

 arch/powerpc/Makefile            |    3 +++
 arch/powerpc/kernel/btext.c      |    4 +++-
 arch/powerpc/kernel/entry_32.S   |    6 ++++++
 arch/powerpc/kernel/time.c       |    2 +-
 arch/powerpc/mm/init_64.c        |   16 ++++------------
 arch/powerpc/mm/tlb_64.c         |    2 --
 arch/powerpc/sysdev/cpm_common.c |    4 +---
 arch/ppc/kernel/entry.S          |    6 ++++++
 include/asm-powerpc/cputable.h   |   22 ++++++++++++----------
 include/asm-powerpc/tlbflush.h   |    4 ++--
 10 files changed, 38 insertions(+), 31 deletions(-)

Becky Bruce (1):
      [POWERPC] Avoid unpaired stwcx. on some processors

Benjamin Herrenschmidt (1):
      [POWERPC] Fix early btext debug on PowerMac

Kumar Gala (2):
      [POWERPC] Add -mno-spe for ARCH=powerpc builds
      [POWERPC] Fix oops related to 4xx flush_tlb_page modification

Olof Johansson (1):
      [POWERPC] Fix CONFIG_SMP=n build error on ppc64

Scott Wood (1):
      [POWERPC] cpm: Fix a couple minor issues in cpm_common.c.

Stephen Rothwell (1):
      [POWERPC] Silence an annoying boot message

Tony Breeds (1):
      [POWERPC] Demote clockevent printk to KERN_DEBUG

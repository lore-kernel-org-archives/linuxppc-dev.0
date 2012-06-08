Return-Path: <paulus@ozlabs.org>
Date: Fri, 8 Jun 2012 20:32:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc fixes
Message-ID: <20120608103249.GA10321@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus,

Two small fixes for powerpc:
* a fix for a regression since 3.2 that causes 4-second (or longer) pauses
* a fix for a potential oops when loading kernel modules on
  32-bit embedded systems.

Please pull (Ben is still off duty).

BTW, should I be using a signed tag for this?

Thanks,
Paul.

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

for you to fetch changes up to 3c75296562f43e6fbc6cddd3de948a7b3e4e9bcf:

  powerpc: Fix kernel panic during kernel module load (2012-06-08 19:59:08 +1000)

----------------------------------------------------------------
Paul Mackerras (1):
      powerpc/time: Sanity check of decrementer expiration is necessary

Steffen Rumler (1):
      powerpc: Fix kernel panic during kernel module load

 arch/powerpc/kernel/module_32.c |   11 +++++------
 arch/powerpc/kernel/time.c      |   14 +++++++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

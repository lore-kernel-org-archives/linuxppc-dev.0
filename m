Return-Path: <paulus@ozlabs.org>
Date: Fri, 15 Jun 2012 17:51:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull a powerpc fix
Message-ID: <20120615075158.GA28023@pale.ozlabs.ibm.com>
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

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git tags/for-linus

for you to fetch changes up to f948501b36c6b3d9352ce212a197098a7e958971:

  Make hard_irq_disable() actually hard-disable interrupts (2012-06-15 15:27:41 +1000)

----------------------------------------------------------------
PowerPC fix for Linus

Just one commit, and a one-liner at that, but an important one;
without it hard_irq_disable() does nothing on powerpc.

----------------------------------------------------------------
Paul Mackerras (1):
      Make hard_irq_disable() actually hard-disable interrupts

 arch/powerpc/include/asm/hw_irq.h |    3 +++
 1 file changed, 3 insertions(+)

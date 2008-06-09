Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18509.7599.970933.555379@cargo.ozlabs.ibm.com>
Date: Mon, 9 Jun 2008 22:10:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get 4 more bug-fix commits, plus one from Stephen Rothwell that
changes one place where we do sprintf(pci_name(dev), ... to use
dev_set_name() instead, so that we don't end up with an error when a
change that is in Greg KH's tree (changing pci_name(dev) to be const)
hits your tree.

Thanks,
Paul.

 arch/powerpc/boot/Makefile      |    4 ++--
 arch/powerpc/kernel/pci_64.c    |    2 +-
 arch/powerpc/kernel/signal_64.c |    4 +++-
 arch/powerpc/mm/mem.c           |    3 +--
 drivers/net/Kconfig             |    2 +-
 include/linux/memory_hotplug.h  |   16 ++++++++--------
 6 files changed, 16 insertions(+), 15 deletions(-)

Adrian Bunk (1):
      [POWERPC] boot/Makefile CONFIG_ variable fixes

Benjamin Herrenschmidt (1):
      [POWERPC] Fix incorrect enabling of VMX when building signal or user context

Nathan Lynch (2):
      [POWERPC] Make walk_memory_resource available with MEMORY_HOTPLUG=n
      [POWERPC] ehea: Remove dependency on MEMORY_HOTPLUG

Stephen Rothwell (1):
      [POWERPC] Use dev_set_name in pci_64.c

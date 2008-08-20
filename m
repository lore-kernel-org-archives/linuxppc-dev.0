Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18603.37996.974247.668984@cargo.ozlabs.ibm.com>
Date: Wed, 20 Aug 2008 13:50:04 +1000
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

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some more bug-fixes for powerpc.

Paul.

 arch/powerpc/kernel/crash_dump.c          |   31 +++++++++++++++++++++=
--------
 arch/powerpc/kernel/ibmebus.c             |   12 -----------
 arch/powerpc/kernel/vio.c                 |    2 +-
 arch/powerpc/platforms/cell/spufs/run.c   |   15 +++++++-------
 arch/powerpc/platforms/cell/spufs/sched.c |   11 ++++++++--
 drivers/of/device.c                       |   10 +++++++++
 6 files changed, 50 insertions(+), 31 deletions(-)

Brian King (1):
      powerpc: Fix vio_bus_probe oops on probe error

Ilpo J=E4rvinen (1):
      powerpc/spufs: Remove invalid semicolon after if statement

Jeremy Kerr (2):
      powerpc/spufs: fix npc setting for NOSCHED contexts
      powerpc/spufs: reference context while dropping state mutex in sc=
heduler

Joachim Fenkes (1):
      powerpc/ibmebus: Restore "name" sysfs attribute on ibmebus device=
s

Michael Ellerman (1):
      powerpc: Fix /dev/oldmem interface for kdump

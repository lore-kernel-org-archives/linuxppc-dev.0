Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18486.37935.242555.465662@cargo.ozlabs.ibm.com>
Date: Fri, 23 May 2008 19:53:51 +1000
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

to get some more small bug and warning fixes for powerpc (and one
commit that just updates some comments).

Thanks,
Paul.

 arch/powerpc/kernel/prom_init_check.sh |    2 +-
 arch/powerpc/mm/pgtable_32.c           |    2 +-
 arch/powerpc/platforms/ps3/mm.c        |    3 +++
 arch/powerpc/sysdev/mpic.c             |   20 +++-----------------
 drivers/block/viodasd.c                |    2 +-
 drivers/cdrom/viocd.c                  |    2 +-
 drivers/char/viocons.c                 |    2 +-
 drivers/char/viotape.c                 |    2 +-
 include/asm-powerpc/mpic.h             |    3 +--
 9 files changed, 13 insertions(+), 25 deletions(-)

David Gibson (1):
      [POWERPC] Fix __set_fixmap() for STRICT_MM_TYPECHECKS

Geoff Levand (1):
      [POWERPC] PS3: Fix memory hotplug

Michael Ellerman (1):
      [POWERPC] Add kernstart_addr to list of allowed symbols in prom_init

Stephen Rothwell (2):
      [POWERPC] mpic: Fix use of uninitialized variable
      [POWERPC] iSeries: Remove unused mail address

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18356.47612.27417.365@cargo.ozlabs.ibm.com>
Date: Fri, 15 Feb 2008 09:00:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
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

to get a collection of bug-fixes and very minor cleanups for powerpc
(plus one commit wiring up the timerfd syscalls).

Thanks,
Paul.

 arch/powerpc/Kconfig                       |    4 ---
 arch/powerpc/boot/Makefile                 |    2 +
 arch/powerpc/boot/ps3-hvcall.S             |    2 +
 arch/powerpc/kernel/Makefile               |    2 +
 arch/powerpc/kernel/process.c              |    2 +
 arch/powerpc/kernel/vdso.c                 |   12 ++++----
 arch/powerpc/platforms/512x/Kconfig        |    1 -
 arch/powerpc/platforms/52xx/Kconfig        |    2 -
 arch/powerpc/platforms/Kconfig             |    2 -
 arch/powerpc/platforms/Kconfig.cputype     |    4 ---
 arch/powerpc/platforms/cell/ras.c          |   11 ++++++-
 arch/powerpc/platforms/embedded6xx/Kconfig |    4 ---
 arch/powerpc/platforms/iseries/vio.c       |    2 +
 drivers/char/hvc_rtas.c                    |    2 +
 drivers/ps3/ps3-lpm.c                      |   22 ++++++++------
 drivers/ps3/ps3-sys-manager.c              |   44 ++++++++++++++++++++--------
 include/asm-powerpc/systbl.h               |    4 ++-
 include/asm-powerpc/unistd.h               |    6 +++-
 include/asm-ppc/page.h                     |    2 +
 19 files changed, 76 insertions(+), 54 deletions(-)

Adrian Bunk (3):
      [POWERPC] vdso_do_func_patch{32,64}() must be __init
      [POWERPC] free_property() must not be __init
      [POWERPC] hvc_rtas_init() must be __init

Geoff Levand (4):
      [POWERPC] PS3: Fix bootwrapper hang bug
      [POWERPC] PS3: Use system reboot on restart
      [POWERPC] PS3: Sys-manager code cleanup
      [POWERPC] PS3: Update sys-manager button events

Grant Likely (1):
      [POWERPC] Remove unused CONFIG_WANT_DEVICE_TREE

Hugh Dickins (1):
      [POWERPC] Fix DEBUG_PREEMPT warning when warning

Kumar Gala (1):
      [POWERPC] Remove generated files on make clean

Michael Ellerman (1):
      [POWERPC] Cell RAS: Remove DEBUG, and add license and copyright

Stefan Roese (1):
      [POWERPC] Fix arch/ppc compilation - add typedef for pgtable_t

Stephen Rothwell (1):
      [POWERPC] Wire up new timerfd syscalls

Takashi Yamamoto (2):
      [POWERPC] PS3: Fix setting bookmark in logical performance monitor
      [POWERPC] PS3: Fix reading pm interval in logical performance monitor

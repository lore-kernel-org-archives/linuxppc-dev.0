Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17455.6204.562884.749301@cargo.ozlabs.ibm.com>
Date: Sun, 2 Apr 2006 10:18:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git
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

Please do a pull from

master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git

to get another batch of powerpc updates.  Nothing major this time,
mostly cleanups and bug-fixes.

Thanks,
Paul.

Anton Blanchard:
      powerpc: trivial spelling fixes in fault.c

Dave Jones:
      powerpc/cell: compile fixes

Heiko J Schick:
      powerpc: Extends HCALL interface for InfiniBand usage

Kumar Gala:
      powerpc: merge machine_check_exception between ppc32 & ppc64
      powerpc: converted embedded platforms to use new define_machine support

Linas Vepstas:
      powerpc/pseries: mutex lock to serialize EEH event processing
      powerpc/pseries: print message if EEH recovery fails
      powerpc/pseries: fix device name printing, again.

Nathan Fontenot:
      powerpc/pseries: EEH Cleanup

Paul Mackerras:
      powerpc: hook up the splice syscall

Segher Boessenkool:
      powerpc/pseries: Change H_StudlyCaps to H_SHOUTING_CAPS

Stephen Rothwell:
      powerpc: iSeries needs slb_initialize to be called

Will Schmidt:
      powerpc/pseries: misc lparcfg fixes

 arch/powerpc/kernel/lparcfg.c               |   33 ++---
 arch/powerpc/kernel/rtas.c                  |   12 +-
 arch/powerpc/kernel/setup_32.c              |    6 -
 arch/powerpc/kernel/setup_64.c              |   10 +
 arch/powerpc/kernel/systbl.S                |    1 
 arch/powerpc/kernel/traps.c                 |    9 -
 arch/powerpc/mm/fault.c                     |    6 -
 arch/powerpc/platforms/83xx/mpc834x_sys.c   |   44 +++---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c   |   44 +++---
 arch/powerpc/platforms/cell/spu_callbacks.c |    1 
 arch/powerpc/platforms/cell/spufs/run.c     |    1 
 arch/powerpc/platforms/pseries/eeh.c        |   62 ++++-----
 arch/powerpc/platforms/pseries/eeh_driver.c |   19 ++-
 arch/powerpc/platforms/pseries/eeh_event.c  |   30 +++-
 arch/powerpc/platforms/pseries/hvCall.S     |  100 ++++++++++++++
 arch/powerpc/platforms/pseries/hvconsole.c  |    6 -
 arch/powerpc/platforms/pseries/hvcserver.c  |   22 ++-
 arch/powerpc/platforms/pseries/lpar.c       |   31 ++--
 arch/powerpc/platforms/pseries/setup.c      |    2 
 arch/powerpc/platforms/pseries/vio.c        |    4 -
 arch/powerpc/platforms/pseries/xics.c       |    8 +
 drivers/char/hvcs.c                         |    2 
 drivers/net/ibmveth.c                       |   30 ++--
 drivers/scsi/ibmvscsi/rpa_vscsi.c           |   10 +
 include/asm-powerpc/eeh.h                   |   20 ---
 include/asm-powerpc/hvcall.h                |  187 +++++++++++++++++++++------
 26 files changed, 447 insertions(+), 253 deletions(-)

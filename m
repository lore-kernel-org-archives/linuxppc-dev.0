Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18456.19061.583776.392078@cargo.ozlabs.ibm.com>
Date: Wed, 30 Apr 2008 20:31:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: [git pull] Please pull powerpc.git master branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

once more.  There are a bunch of updates for the embedded MPC5200
based platforms, some spufs updates for Cell, and two bug fixes from
Michael Ellerman.

Sorry about missing the diffstat last time.

Thanks,
Paul.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |   12 
 arch/powerpc/boot/dts/cm5200.dts                   |   98 +-
 arch/powerpc/boot/dts/lite5200.dts                 |  132 +-
 arch/powerpc/boot/dts/lite5200b.dts                |  146 +-
 arch/powerpc/boot/dts/motionpro.dts                |  118 +-
 arch/powerpc/boot/dts/pcm030.dts                   |  363 ++++++
 arch/powerpc/boot/dts/tqm5200.dts                  |   80 +
 arch/powerpc/configs/52xx/cm5200_defconfig         | 1099 ++++++++++++++++++
 arch/powerpc/configs/52xx/lite5200b_defconfig      | 1049 +++++++++++++++++
 arch/powerpc/configs/52xx/motionpro_defconfig      | 1107 ++++++++++++++++++
 arch/powerpc/configs/52xx/pcm030_defconfig         | 1115 ++++++++++++++++++
 arch/powerpc/configs/52xx/tqm5200_defconfig        | 1214 ++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec.c                |   12 
 arch/powerpc/kernel/setup_64.c                     |    9 
 arch/powerpc/platforms/52xx/Kconfig                |    6 
 arch/powerpc/platforms/52xx/Makefile               |    2 
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |    1 
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c         |  465 ++++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   38 +
 arch/powerpc/platforms/cell/spufs/.gitignore       |    2 
 arch/powerpc/platforms/cell/spufs/context.c        |    4 
 arch/powerpc/platforms/cell/spufs/file.c           |  166 +++
 arch/powerpc/platforms/cell/spufs/run.c            |    2 
 arch/powerpc/platforms/cell/spufs/sched.c          |    4 
 arch/powerpc/platforms/cell/spufs/spufs.h          |   33 +
 arch/powerpc/platforms/cell/spufs/sputrace.c       |   36 -
 drivers/net/fec_mpc52xx.c                          |   23 
 drivers/serial/mpc52xx_uart.c                      |    2 
 28 files changed, 7009 insertions(+), 329 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/pcm030.dts
 create mode 100644 arch/powerpc/configs/52xx/cm5200_defconfig
 create mode 100644 arch/powerpc/configs/52xx/lite5200b_defconfig
 create mode 100644 arch/powerpc/configs/52xx/motionpro_defconfig
 create mode 100644 arch/powerpc/configs/52xx/pcm030_defconfig
 create mode 100644 arch/powerpc/configs/52xx/tqm5200_defconfig
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_gpio.c
 create mode 100644 arch/powerpc/platforms/cell/spufs/.gitignore

Bartlomiej Sieka (1):
      [POWERPC] mpc5200: defconfigs for CM5200, Lite5200B, Motion-PRO and TQM5200

Christoph Hellwig (1):
      [POWERPC] spufs: add context switch notification log

Grant Likely (2):
      [POWERPC] mpc5200: Fix unterminated of_device_id table
      [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1 format

Julio M. Merino Vidal (4):
      [POWERPC] spufs: add sputrace marker parameter names
      [POWERPC] spufs: add marker for destroy_spu_context
      [POWERPC] spufs: fix marker name for find_victim
      [POWERPC] spufs: trace spu_acquire_saved events

Kumar Gala (1):
      [POWERPC] spufs: add .gitignore for spu_save_dump.h & spu_restore_dump.h

Michael Ellerman (2):
      [POWERPC] Make emergency stack safe for current_thread_info() use
      [POWERPC] Fix crashkernel= handling when no crashkernel= specified

Sascha Hauer (2):
      [POWERPC] mpc5200: add interrupt type function
      [POWERPC] mpc5200: Fix FEC error handling on FIFO errors

s.hauer@pengutronix.de (2):
      [POWERPC] mpc5200: add gpiolib support for mpc5200
      [POWERPC] mpc5200: add Phytec pcm030 board support

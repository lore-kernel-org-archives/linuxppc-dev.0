Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4F489DDEA3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 16:00:59 +1100 (EST)
Date: Sun, 2 Dec 2007 23:04:47 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull pasemi.git for-2.6.25 branch
Message-ID: <20071203050446.GC24492@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.25

For the following patches queued up for 2.6.25. All but one are PA
Semi-specific (the i2c boardinfo consolidation that's a pre-req for the
platform-specific one).

 arch/powerpc/platforms/pasemi/Kconfig     |    2 
 arch/powerpc/platforms/pasemi/Makefile    |    2 
 arch/powerpc/platforms/pasemi/cpufreq.c   |   19 +++++-
 arch/powerpc/platforms/pasemi/gpio_mdio.c |   94 ++++++++++++++++++------------
 arch/powerpc/platforms/pasemi/misc.c      |   66 +++++++++++++++++++++
 arch/powerpc/platforms/pasemi/pasemi.h    |    6 +
 arch/powerpc/platforms/pasemi/powersave.S |   11 +++
 arch/powerpc/platforms/pasemi/setup.c     |   16 ++++-
 arch/powerpc/sysdev/Makefile              |    1 
 arch/powerpc/sysdev/fsl_soc.c             |   40 ------------
 arch/powerpc/sysdev/i2c_of_mapping.c      |   61 +++++++++++++++++++
 drivers/char/hw_random/Kconfig            |    2 
 drivers/char/hw_random/pasemi-rng.c       |    7 --
 drivers/edac/pasemi_edac.c                |    4 -
 include/asm-powerpc/i2c_of.h              |   14 ++++
 15 files changed, 256 insertions(+), 89 deletions(-)


Olof Johansson (7):
      [POWERPC] pasemi: clean up mdio_gpio a bit
      [POWERPC] pasemi: Broaden specific references to 1682M
      [POWERPC] pasemi: Don't enter powersaving states from elevated astates
      [POWERPC] pasemi: Move cpus to hold loop before restart
      [POWERPC] Consolidate compatible-to-i2c_boardinfo mapping code
      [POWERPC] pasemi: Register i2c_board_info
      [POWERPC] pasemi: Fix module information for gpio-mdio


Thanks,

Olof

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18497.2162.859003.143787@cargo.ozlabs.ibm.com>
Date: Sat, 31 May 2008 18:12:34 +1000
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

to get four more bug-fixes for powerpc (including Ben's patch adding
memory clobbers to the asm for I/O accessors) and a pasemi defconfig
update.

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |   10 +-
 arch/powerpc/configs/pasemi_defconfig  |  172 +++++++++++++++++++++-----------
 arch/ppc/kernel/ppc_ksyms.c            |    2 
 drivers/pcmcia/electra_cf.c            |    1 
 include/asm-powerpc/io.h               |   12 +-
 5 files changed, 126 insertions(+), 71 deletions(-)

Benjamin Herrenschmidt (1):
      [POWERPC] Add "memory" clobber to MMIO accessors

Olof Johansson (2):
      electra_cf: Add MODULE_DEVICE_TABLE()
      [POWERPC] pasemi: update pasemi_defconfig, enable electra_cf

Timur Tabi (1):
      [POWERPC] Fix DMA nodes in the MPC8610 HPCD device tree

Tony Breeds (1):
      [POWERPC] Export empty_zero_page and copy_page in arch/ppc

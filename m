Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17412.15183.885850.557891@cargo.ozlabs.ibm.com>
Date: Tue, 28 Feb 2006 23:00:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
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

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

Just four small bugfixes this time.

Thanks,
Paul.

Benjamin Herrenschmidt:
      powerpc: vdso 64bits gettimeofday bug

John Rose:
      powerpc: fix dynamic PCI probe regression

Michael Ellerman:
      powerpc/iseries: Fix double phys_to_abs bug in htab_bolt_mapping

Olaf Hering:
      powerpc: fix NULL pointer in handle_eeh_events

 arch/powerpc/kernel/vdso64/gettimeofday.S   |    4 ++-
 arch/powerpc/mm/hash_utils_64.c             |    2 +-
 arch/powerpc/platforms/pseries/eeh.c        |   14 +++++++++++
 arch/powerpc/platforms/pseries/eeh_driver.c |    2 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c  |   36 +++++++++++++++------------
 include/asm-powerpc/eeh.h                   |    7 +++--
 6 files changed, 42 insertions(+), 23 deletions(-)

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17497.11957.878902.757294@cargo.ozlabs.ibm.com>
Date: Thu, 4 May 2006 08:29:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch
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

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Five smallish bugfixes, plus one commit from me that has no effect on
existing machines, but will allow the kernel to run on some machines
that will shortly be released.

Thanks,
Paul.

Ananth N Mavinakayanahalli:
      powerpc/kprobes: fix singlestep out-of-line

Linas Vepstas:
      powerpc/pseries: avoid crash in PCI code if mem system not up

Paul Mackerras:
      powerpc: Fix incorrect might_sleep in __get_user/__put_user on kernel addresses
      powerpc: Use the ibm,pa-features property if available

Vitaly Bordug:
      ppc32 CPM_UART: Fixed break send on SCC
      ppc32 CPM_UART: fixes and improvements

 arch/powerpc/kernel/kprobes.c              |   14 +++---
 arch/powerpc/kernel/prom.c                 |   70 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/eeh_event.c |    8 +++
 arch/ppc/platforms/mpc866ads_setup.c       |    2 -
 drivers/serial/cpm_uart/cpm_uart.h         |   19 ++++++--
 drivers/serial/cpm_uart/cpm_uart_core.c    |   37 ++++++++++++---
 drivers/serial/cpm_uart/cpm_uart_cpm1.c    |    2 +
 drivers/serial/cpm_uart/cpm_uart_cpm2.c    |    2 +
 include/asm-powerpc/uaccess.h              |   19 +++++---
 include/asm-ppc/commproc.h                 |    1 
 include/asm-ppc/cpm2.h                     |    2 -
 include/linux/fs_uart_pd.h                 |   60 ++++++++++++++++++++++++
 12 files changed, 209 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/fs_uart_pd.h

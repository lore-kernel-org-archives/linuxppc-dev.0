Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BD27DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 21:00:46 +1100 (EST)
Date: Sat, 8 Dec 2007 13:00:25 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull linux-2.6-8xx.git for-paulus branch
Message-ID: <20071208130025.09021cb0@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

please do 
git-pull git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6-8xx.git for-paulus

to receive the following updates:

Jochen Friedrich (4):
      powerpc: fix typo #ifdef -> #ifndef
      powerpc: kill non-existent symbols from ksyms and commproc.h
      powerpc: Add support for PORTA and PORTB odr registers
      powerpc: Move CPM command handling into the cpm drivers

Scott Wood (1):
      8xx: Convert mpc866ads to the new device binding.

 arch/powerpc/boot/dts/mpc866ads.dts          |  156 +++++++++------
 arch/powerpc/kernel/ppc_ksyms.c              |   12 -
 arch/powerpc/platforms/8xx/Kconfig           |    1 +
 arch/powerpc/platforms/8xx/mpc86xads.h       |   44 ----
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |  289 +++++++-------------------
 arch/powerpc/sysdev/commproc.c               |   47 ++++-
 arch/powerpc/sysdev/cpm2_common.c            |   25 +++
 drivers/net/fs_enet/mac-fcc.c                |   10 +-
 drivers/net/fs_enet/mac-scc.c                |   13 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.c      |    6 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    8 +-
 include/asm-powerpc/commproc.h               |    3 -
 include/asm-powerpc/cpm.h                    |    1 +
 13 files changed, 250 insertions(+), 365 deletions(-)


-- 
Sincerely, Vitaly

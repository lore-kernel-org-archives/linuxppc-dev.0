Return-Path: <sfr@canb.auug.org.au>
From: sfr@canb.auug.org.au
To: paulus@samba.org
Subject: [PATCH 00/15] powerpc: move some header files
Date: Wed, 05 Apr 2006 15:10:34 +1000
Message-Id: <11442138494042-git-send-email-sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch set moves sufficient include files from include/asm-ppc
to include/asm-powerpc to allow us to remove the include hack in the
arch/powerpc/Makefile.

 b/arch/powerpc/Makefile           |   21 ++------------
 b/include/asm-powerpc/amigappc.h  |    9 ++----
 b/include/asm-powerpc/bootinfo.h  |    8 ++---
 b/include/asm-powerpc/highmem.h   |   11 +++----
 b/include/asm-powerpc/hydra.h     |    8 ++---
 b/include/asm-powerpc/mpc83xx.h   |    7 ++--
 b/include/asm-powerpc/mpc85xx.h   |    9 ++----
 b/include/asm-powerpc/mpc8xx.h    |   10 +++---
 b/include/asm-powerpc/ocp.h       |    7 ++--
 b/include/asm-powerpc/ocp_ids.h   |    6 ++--
 b/include/asm-powerpc/open_pic.h  |   10 +++---
 b/include/asm-powerpc/pnp.h       |    8 ++---
 b/include/asm-powerpc/reg_booke.h |   55 +++++++++++++++++++------------------- b/include/asm-powerpc/residual.h  |    6 ++--
 b/include/asm-powerpc/suspend.h   |   17 +++++++++++
 include/asm-ppc/suspend.h         |   12 --------
 16 files changed, 95 insertions(+), 109 deletions(-)

Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>

P.S. these are available in my private git tree if you want them.

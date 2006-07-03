Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17577.36374.520491.763102@cargo.ozlabs.ibm.com>
Date: Tue, 4 Jul 2006 07:37:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Re: please pull powerpc.git 'master' branch
In-Reply-To: <17577.2014.880854.217553@cargo.ozlabs.ibm.com>
References: <17577.2014.880854.217553@cargo.ozlabs.ibm.com>
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

I just pushed a few more commits: Stephen Rothwell noticed that I had
forgotten to add one file, and Kumar Gala had an embedded PowerPC 83xx
update that he wanted me to pull.

Paul.

Benjamin Herrenschmidt:
      [POWERPC] Actually copy over i8259.c to arch/ppc/syslib this time

Kim Phillips:
      Documentation: correct values in MPC8548E SEC example node
      powerpc: Add base support for the Freescale MPC8349E-mITX eval board
      powerpc: add defconfig for Freescale MPC8349E-mITX board

 Documentation/powerpc/booting-without-of.txt |    4 
 arch/powerpc/configs/mpc834x_itx_defconfig   | 1336 ++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig          |   11 
 arch/powerpc/platforms/83xx/Makefile         |    1 
 arch/powerpc/platforms/83xx/mpc834x_itx.c    |  156 +++
 arch/powerpc/platforms/83xx/mpc834x_itx.h    |   23 
 arch/ppc/syslib/i8259.c                      |  212 ++++
 7 files changed, 1740 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc834x_itx_defconfig
 create mode 100644 arch/powerpc/platforms/83xx/mpc834x_itx.c
 create mode 100644 arch/powerpc/platforms/83xx/mpc834x_itx.h
 create mode 100644 arch/ppc/syslib/i8259.c

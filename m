Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 716A8B7B9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 13:09:58 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D30E3DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 13:09:57 +1000 (EST)
Date: Thu, 6 Aug 2009 22:09:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0908062209340.7477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/boot/dts/gef_sbc310.dts      |   64 +++-
 arch/powerpc/boot/dts/mgcoge.dts          |   53 +++
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |    2
 arch/powerpc/boot/dts/mpc8377_wlan.dts    |  464 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |    2
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |    2
 arch/powerpc/boot/dts/mpc8536ds.dts       |   32 +-
 arch/powerpc/boot/dts/mpc8536ds_36b.dts   |  467 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts      |   20 +
 arch/powerpc/mm/fsl_booke_mmu.c           |    2
 arch/powerpc/platforms/82xx/mgcoge.c      |   69 +++-
 arch/powerpc/platforms/83xx/Kconfig       |    4
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |   28 +
 arch/powerpc/platforms/83xx/mpc83xx.h     |    4
 arch/powerpc/platforms/86xx/gef_ppc9a.c   |   37 +-
 arch/powerpc/sysdev/fsl_rio.c             |   18 -
 arch/powerpc/sysdev/ipic.c                |    7
 arch/powerpc/sysdev/qe_lib/qe_ic.c        |    5
 18 files changed, 1219 insertions(+), 61 deletions(-)

Anton Vorontsov (3):
      powerpc/83xx: Add support for MPC8377E-WLAN boards
      powerpc/85xx: Add support for I2C EEPROMs on MPC8548CDS boards
      powerpc/83xx: Add eSDHC support for MPC837xE-RDB/WLAN boards

Heiko Schocher (1):
      powerpc/82xx: mgcoge - updates for 2.6.32

Julia Lawall (3):
      powerpc/fsl_rio: Add kmalloc NULL tests
      powerpc/ipic: introduce missing kfree
      powerpc/qe: introduce missing kfree

Kumar Gala (2):
      powerpc/85xx: Move mpc8536ds.dts to address-cells/size-cells = <2>
      powerpc/85xx: Added 36-bit physical device tree for mpc8572ds board

Martyn Welch (3):
      powerpc/86xx: Correct reading of information presented in cpuinfo
      powerpc/86xx: Enable XMC site on GE Fanuc SBC310
      powerpc/86xx: Update GE Fanuc sbc310 DTS

Roel Kluin (1):
      powerpc/fsl-booke: read buffer overflow

Sebastian Andrzej Siewior (1):
      powerpc/ipic: unmask all interrupt sources

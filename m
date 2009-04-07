Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B1A0DDFA1
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:42:15 +1000 (EST)
Date: Tue, 7 Apr 2009 01:42:11 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge'
Message-ID: <Pine.LNX.4.64.0904070139010.11639@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are all either regressions or bug fixes.

- k

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/boot/dts/tqm8540.dts           |    4
 arch/powerpc/boot/dts/tqm8541.dts           |    4
 arch/powerpc/boot/dts/tqm8548-bigflash.dts  |    8 -
 arch/powerpc/boot/dts/tqm8548.dts           |    8 -
 arch/powerpc/boot/dts/tqm8555.dts           |    4
 arch/powerpc/boot/dts/tqm8560.dts           |    4
 arch/powerpc/configs/85xx/tqm8548_defconfig |  164 ++++++++--------------------
 arch/powerpc/include/asm/mmu.h              |    6 +
 arch/powerpc/include/asm/ppc-opcode.h       |   13 +-
 arch/powerpc/kernel/cputable.c              |    2
 arch/powerpc/mm/tlb_nohash_low.S            |   14 ++
 11 files changed, 95 insertions(+), 136 deletions(-)

Kumar Gala (2):
      powerpc: Fix tlbilx opcode
      powerpc: Add support for early tlbilx opcode

Wolfgang Grandegger (3):
      powerpc/85xx: TQM85xx: correct address of LM75 I2C device nodes
      powerpc/85xx: TQM8548: use proper phy-handles for enet2 and enet3
      powerpc/85xx: TQM8548: update defconfig

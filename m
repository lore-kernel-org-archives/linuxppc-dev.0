Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85D1CDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:55:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18934.39491.9616.529066@cargo.ozlabs.ibm.com>
Date: Tue, 28 Apr 2009 15:55:15 +1000
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

to get a collection of bug fixes for powerpc.

Thanks,
Paul.

 MAINTAINERS                           |    2 +
 arch/powerpc/boot/4xx.c               |   56 +++++++++++++++++++++++++--------
 arch/powerpc/boot/dts/gef_ppc9a.dts   |    1 +
 arch/powerpc/include/asm/elf.h        |    1 +
 arch/powerpc/include/asm/mmu.h        |    6 ----
 arch/powerpc/include/asm/ppc-opcode.h |   11 +-----
 arch/powerpc/kernel/cputable.c        |    2 +
 arch/powerpc/mm/tlb_nohash_low.S      |   16 +--------
 arch/powerpc/platforms/cell/Kconfig   |    5 ++-
 arch/powerpc/platforms/ps3/setup.c    |    4 --
 10 files changed, 54 insertions(+), 50 deletions(-)

Geoff Levand (1):
      powerpc/ps3: Fix build error on UP

Josh Boyer (1):
      maintainers: Fix PowerPC 4xx git tree

Kumar Gala (2):
      Revert "powerpc: Add support for early tlbilx opcode"
      powerpc: ppc32 needs elf_read_implies_exec()

Martyn Welch (1):
      powerpc/86xx: Add device_type entry to soc for ppc9a

Michael Ellerman (1):
      powerpc/cell: Select PCI for IBM_CELL_BLADE AND CELLEB

Stephen Rothwell (1):
      powerpc: fix for long standing bug noticed by gcc 4.4.0

Valentine Barshak (1):
      powerpc/44x: Correct memory size calculation for denali-based boards

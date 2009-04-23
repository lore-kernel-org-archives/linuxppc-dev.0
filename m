Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA1A5DE616
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:55:31 +1000 (EST)
Date: Thu, 23 Apr 2009 08:55:23 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'merge' branch for 2.6.30
Message-ID: <Pine.LNX.4.64.0904230854310.17039@localhost.localdomain>
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

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/include/asm/mmu.h        |    6 ------
 arch/powerpc/include/asm/ppc-opcode.h |   11 +----------
 arch/powerpc/kernel/cputable.c        |    2 +-
 arch/powerpc/mm/tlb_nohash_low.S      |   16 ++--------------
 4 files changed, 4 insertions(+), 31 deletions(-)

Kumar Gala (1):
      Revert "powerpc: Add support for early tlbilx opcode"

Stephen Rothwell (1):
      powerpc: fix for long standing bug noticed by gcc 4.4.0

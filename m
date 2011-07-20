Return-Path: <aymane@elkhashab.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [207.114.241.63])
	by ozlabs.org (Postfix) with ESMTP id 48E0AB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 23:02:42 +1000 (EST)
From: Ayman Elkhashab <aymane@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Tony Breeds <tony@bakeyournoodle.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/1] powerpc/4xx: enable and fix pcie gen1/gen2 on the 460sx
Date: Wed, 20 Jul 2011 08:02:28 -0500
Message-Id: <1311166949-2543-1-git-send-email-aymane@elkhashab.com>
In-Reply-To: <1310603611-8960-2-git-send-email-ayman@elkhashab.com>
References: <1310603611-8960-2-git-send-email-ayman@elkhashab.com>
Cc: Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ayman El-Khashab <ayman@elkhashab.com>

Changes from v1->v2
Added definitions for the bits in the OMRxMSKL registers
Refactored the setting of the OMRxMSKL registers for the 460SX
Added bit defines for the PECFG_460SX_DLLSTA register

Changes from v2->v3
Fixed commit message to be more clear as to what was done

Ayman El-Khashab (1):
  powerpc/4xx: enable and fix pcie gen1/gen2 on the 460sx

 arch/powerpc/sysdev/ppc4xx_pci.c |   89 ++++++++++++++++++++++++++++++-------
 arch/powerpc/sysdev/ppc4xx_pci.h |   12 +++++
 2 files changed, 84 insertions(+), 17 deletions(-)

-- 
1.7.4.3

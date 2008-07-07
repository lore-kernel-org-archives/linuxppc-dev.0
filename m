Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080707142850.034542257@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:28:50 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [patch 0/5] Strong Access Ordering
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,
Please include these patches in powerpc-next.

Changelog since posting to linuxppc-dev on June 18th:
- rebased on top of powerpc-next branch
- Added arch_validate_prot define as suggested by Andrew
- Added #ifdef CONFIG_PPC64 in include/powerpc/mman.h to fix 32-bit build

Thanks,
Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center

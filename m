Return-Path: <Sudeep.KarkadaNagesha@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 47FEA2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 20:52:53 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] move of_find_next_cache_node to DT core
Date: Wed, 18 Sep 2013 11:53:03 +0100
Message-Id: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi,

The cache bindings are generic and used by many other architectures
apart from PPC. These patches fixes and move the existing definition
of of_find_next_cache_node to DT common code.

Regards,
Sudeep

Sudeep KarkadaNagesha (2):
  powerpc: remove big endianness assumption in of_find_next_cache_node
  of: move definition of of_find_next_cache_node into common code.

 arch/powerpc/include/asm/prom.h |  3 ---
 arch/powerpc/kernel/prom.c      | 31 -------------------------------
 drivers/of/base.c               | 31 +++++++++++++++++++++++++++++++
 include/linux/of.h              |  2 ++
 4 files changed, 33 insertions(+), 34 deletions(-)

-- 
1.8.1.2

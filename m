Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id D46752C0255
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 03:10:05 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, linux@lists.openrisc.net,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/4] microblaze: remove undefined of_get_cpu_node
 declaration
Date: Thu, 15 Aug 2013 18:09:37 +0100
Message-Id: <1376586580-5409-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch removes the declaration of the function 'of_get_cpu_node'
which is not defined for microblaze. This is in preparation to move
it's definition from PPC to DT common code.

Michal Simek says: "it was just there because Microblaze
was based on powerpc code"

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/prom.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/a=
sm/prom.h
index 20c5e8e..9977816 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -50,9 +50,6 @@ void of_parse_dma_window(struct device_node *dn, const vo=
id *dma_window_prop,
=20
 extern void kdump_move_device_tree(void);
=20
-/* CPU OF node matching */
-struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
=20
--=20
1.8.1.2

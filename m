Return-Path: <tinamdar@amcc.com>
From: Tanmay Inamdar <tinamdar@apm.com>
To: benh@kernel.crashing.org, jwboyer@gmail.com, grant.likely@secretlab.ca,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org
Subject: [V2 2/5] powerpc: 40x: Add AHB, APB of_device_ids
Date: Mon,  9 Apr 2012 12:50:49 +0530
Message-Id: <1333956052-25319-2-git-send-email-tinamdar@apm.com>
In-Reply-To: <1333956052-25319-1-git-send-email-tinamdar@apm.com>
References: <1333956052-25319-1-git-send-email-tinamdar@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding of_device_id's for AHB and APB buses used in klondike (APM8018X) in
platforms/40x/ppc40x_simple.c file

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
:100644 100644 9761206... 7b518ed... M	arch/powerpc/platforms/40x/ppc40x_simple.c
 arch/powerpc/platforms/40x/ppc40x_simple.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 9761206..7b518ed 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -29,6 +29,8 @@ static __initdata struct of_device_id ppc40x_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
+	{ .compatible = "apm,ahb", },
+	{ .compatible = "apm,apb", },
 	{ .compatible = "simple-bus", },
 	{},
 };
-- 
1.6.1.rc3

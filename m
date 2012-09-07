Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc: cleanup old DABRX #defines
Date: Fri,  7 Sep 2012 17:24:58 +1000
Message-Id: <1347002698-7341-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1347002698-7341-1-git-send-email-mikey@neuling.org>
References: <1347002698-7341-1-git-send-email-mikey@neuling.org>
In-Reply-To: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
References: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are no longer used so get rid of them

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hvcall.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 423cf9e..7a86706 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -152,11 +152,6 @@
 #define H_VASI_RESUMED          5
 #define H_VASI_COMPLETED        6
 
-/* DABRX flags */
-#define H_DABRX_HYPERVISOR	(1UL<<(63-61))
-#define H_DABRX_KERNEL		(1UL<<(63-62))
-#define H_DABRX_USER		(1UL<<(63-63))
-
 /* Each control block has to be on a 4K boundary */
 #define H_CB_ALIGNMENT          4096
 
-- 
1.7.9.5

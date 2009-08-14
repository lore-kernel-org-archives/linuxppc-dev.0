Return-Path: <Paul.Gortmaker@windriver.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] sbc8560: remove "has-rstcr" from global utilities block
Date: Fri, 14 Aug 2009 12:13:54 -0400
Message-Id: <4935eb5c085f994943e2f989a74c1333c60aebf1.1250266325.git.paul.gortmaker@windriver.com>
In-Reply-To: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
References: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
In-Reply-To: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
References: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The earlier mpc8560 CPUs don't have the RSTCR at 0xe00b0
in the GUTS.  The generic reboot code uses this tag to
determine if it should be using the RSTCR for reboot, so
remove it from the board definition.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8560.dts |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 239d57a..9e13ed8 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -303,7 +303,6 @@
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8560-guts";
 			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
 		};
 	};
 
-- 
1.6.3.3

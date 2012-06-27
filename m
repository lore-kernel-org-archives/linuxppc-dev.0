Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: fix whitespace in eeh
Date: Wed, 27 Jun 2012 14:12:01 +1000
Message-ID: <3149.1340770321@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8752f79..c33360ec 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -81,7 +81,7 @@ static int pseries_eeh_init(void)
 	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
 	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
-	ibm_configure_bridge		= rtas_token ("ibm,configure-bridge");
+	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
 
 	/* necessary sanity check */
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
@@ -89,7 +89,7 @@ static int pseries_eeh_init(void)
 			__func__);
 		return -EINVAL;
 	} else if (ibm_set_slot_reset == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm, set-slot-reset> invalid\n",
+		pr_warning("%s: RTAS service <ibm,set-slot-reset> invalid\n",
 			__func__);
 		return -EINVAL;
 	} else if (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&

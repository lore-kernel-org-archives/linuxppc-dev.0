Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 31B5A67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 23:20:53 +1100 (EST)
Message-ID: <422EEA20.4050907@varma-el.com>
Date: Wed, 09 Mar 2005 15:20:48 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: RFC/Commit: New ocp id for CANbus devs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Paul,

Pls. commit this patch, its needed for MPC5200 Can

Regards
Andrey Volkov

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
--
ChangeSet@1.2159, 2005-03-09 15:05:37+03:00, avolkov@varma-el.com
   ocp_ids.h:
     New number for onboard CANbus devs.


  ocp_ids.h |    1 +
  1 files changed, 1 insertion(+)


diff -Nru a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
--- a/include/asm-ppc/ocp_ids.h	2005-03-09 15:07:51 +03:00
+++ b/include/asm-ppc/ocp_ids.h	2005-03-09 15:07:51 +03:00
@@ -62,6 +62,7 @@
  #define OCP_FUNC_RGMII		0x00D3
  #define OCP_FUNC_TAH		0x00D4
  #define OCP_FUNC_SEC2		0x00D5	/* Crypto/Security 2.0 */
+#define OCP_FUNC_CAN		0x00D6	/* CAN bus device */

  /* Network 0x0200 - 0x02FF */
  #define OCP_FUNC_EMAC		0x0200

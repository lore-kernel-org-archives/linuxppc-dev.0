Return-Path: <geoff@white.local.net>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7A39CDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 18:45:06 +1000 (EST)
Message-Id: <20070912084314.283868172@am.sony.com>
References: <20070912084314.057513210@am.sony.com>
Date: Wed, 12 Sep 2007 01:43:16 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 2/3] PS3: Add new LV1 error codes
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3: Add new error codes that may be returned by the LV1 hypervisor

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 include/asm-powerpc/ps3.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -229,6 +229,9 @@ enum lv1_result {
 	LV1_INVALID_CLASS_ID            = -21,
 	LV1_CONSTRAINT_NOT_SATISFIED    = -22,
 	LV1_ALIGNMENT_ERROR             = -23,
+	LV1_HARDWARE_ERROR              = -24,
+	LV1_INVALID_DATA_FORMAT         = -25,
+	LV1_INVALID_OPERATION           = -26,
 	LV1_INTERNAL_ERROR              = -32768,
 };
 
@@ -284,6 +287,12 @@ static inline const char* ps3_result(int
 		return "LV1_CONSTRAINT_NOT_SATISFIED (-22)";
 	case LV1_ALIGNMENT_ERROR:
 		return "LV1_ALIGNMENT_ERROR (-23)";
+	case LV1_HARDWARE_ERROR:
+		return "LV1_HARDWARE_ERROR (-24)";
+	case LV1_INVALID_DATA_FORMAT:
+		return "LV1_INVALID_DATA_FORMAT (-25)";
+	case LV1_INVALID_OPERATION:
+		return "LV1_INVALID_OPERATION (-26)";
 	case LV1_INTERNAL_ERROR:
 		return "LV1_INTERNAL_ERROR (-32768)";
 	default:

-- 

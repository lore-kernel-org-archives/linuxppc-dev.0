Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ff0R5y2LzF1Pp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 20:25:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w47AO4M0007432
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 06:25:57 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htkwbarja-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 06:25:57 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 7 May 2018 11:25:54 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 3/3] hwmon: (ibmpowernv) Add energy sensors
Date: Mon,  7 May 2018 15:55:38 +0530
In-Reply-To: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1525688738-9185-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exports the accumulated power numbers of each power
sensor maintained by OCC.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/hwmon/ibmpowernv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 74d9b5a..0298745 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -51,6 +51,7 @@ enum sensors {
 	POWER_SUPPLY,
 	POWER_INPUT,
 	CURRENT,
+	ENERGY,
 	MAX_SENSOR_TYPE,
 };
 
@@ -78,6 +79,7 @@ enum sensors {
 	{ "in"    },
 	{ "power" },
 	{ "curr"  },
+	{ "energy" },
 };
 
 struct sensor_data {
-- 
1.8.3.1

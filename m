Return-Path: <fengguang.wu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40846t0SrkzF0wy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 15:29:25 +1100 (AEDT)
Date: Sun, 25 Mar 2018 12:28:12 +0800
From: kbuild test robot <lkp@intel.com>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: kbuild-all@01.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] libnvdimm: bus_desc can be static
Message-ID: <20180325042812.GA28332@lkp-ib03.lkp.intel.com>
References: <20180323081209.31387-3-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180323081209.31387-3-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Fixes: 6cb2b51b9b76 ("libnvdimm: Add device-tree based driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 of_nvdimm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/of_nvdimm.c b/drivers/nvdimm/of_nvdimm.c
index 79c2829..4ed373d 100644
--- a/drivers/nvdimm/of_nvdimm.c
+++ b/drivers/nvdimm/of_nvdimm.c
@@ -15,7 +15,7 @@
  * for dispatching regions into the correct bus type, but this is useful
  * for now.
  */
-struct nvdimm_bus_descriptor bus_desc;
+static struct nvdimm_bus_descriptor bus_desc;
 struct nvdimm_bus *bus;
 
 /* region driver */

Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzZgD2MNqzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 21:53:44 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5UBmYin067608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 07:53:42 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bdf271rmy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 07:53:42 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 30 Jun 2017 12:53:40 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Patrice Chotard <patrice.chotard@st.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org,
 kernel@stlinux.com
Subject: [PATCH v1 1/2] mmc/host: add FSP2(ppc476fpe) into depends for sdhci-st
Date: Fri, 30 Jun 2017 14:53:30 +0300
Message-Id: <20170630115331.73869-2-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

shdci-st driver can be used for ppc476 fsp2 soc.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2eb9701..edf5787 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -354,7 +354,7 @@ config MMC_MOXART
 
 config MMC_SDHCI_ST
 	tristate "SDHCI support on STMicroelectronics SoC"
-	depends on ARCH_STI
+	depends on ARCH_STI || FSP2
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-- 
1.7.1

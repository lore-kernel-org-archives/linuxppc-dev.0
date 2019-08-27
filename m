Return-Path: <SRS0=ZD8a=WX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A453EC3A5A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 15:26:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F00D2070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 15:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F00D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Ht5J66XVzDqQG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 01:26:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Hsvs20wyzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 01:18:29 +1000 (AEST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2019 08:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; d="scan'208";a="209789081"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 08:18:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 169A8BB; Tue, 27 Aug 2019 18:18:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v1 2/2] PCI/AER: Update parameter descriptions to satisfy
 kernel-doc validator
Date: Tue, 27 Aug 2019 18:18:23 +0300
Message-Id: <20190827151823.75312-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
References: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kernel-doc validator complains:

aer.c:207: warning: Function parameter or member 'str' not described in 'pcie_ecrc_get_policy'
aer.c:1209: warning: Function parameter or member 'irq' not described in 'aer_isr'
aer.c:1209: warning: Function parameter or member 'context' not described in 'aer_isr'
aer.c:1209: warning: Excess function parameter 'work' description in 'aer_isr'

Fix the above accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f883f81d759a..6073eaab099d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -202,6 +202,7 @@ void pcie_set_ecrc_checking(struct pci_dev *dev)
 
 /**
  * pcie_ecrc_get_policy - parse kernel command-line ecrc option
+ * @str: ECRC policy from kernel command line to use
  */
 void pcie_ecrc_get_policy(char *str)
 {
@@ -1201,7 +1202,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 
 /**
  * aer_isr - consume errors detected by root port
- * @work: definition of this work item
+ * @irq: IRQ assigned to Root Port
+ * @context: pointer to Root Port data structure
  *
  * Invoked, as DPC, when root port records new detected error
  */
-- 
2.23.0.rc1


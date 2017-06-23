Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvNBM09SFzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 01:47:38 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5NFhfxu048795
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 11:47:36 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b94whjrbj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 11:47:36 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 23 Jun 2017 16:47:34 +0100
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
Subject: [PATCH 0/2] add eMMC support for fsp2 board
Date: Fri, 23 Jun 2017 18:47:24 +0300
Message-Id: <20170623154726.15019-1-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsp2 based on powerpc 476fpe using eMMC arasan, so we added support
of this inside our dts and also enabled via additional
dependence for sdhci-st driver in Kconfig.

this code depends on commit c4b56b023daa91953e9ebe91143e6ca156f0bcb7
which is located in powerpc linux tree in 'next' branch.

Ivan Mikhaylov (2):
  mmc/host: add FSP2(ppc476fpe) into depends for sdhci-st
  44x/fsp2: enable eMMC arasan for fsp2 platform

 arch/powerpc/boot/dts/fsp2.dts          |   19 +++++++++++++++++++
 arch/powerpc/configs/44x/fsp2_defconfig |    2 ++
 drivers/mmc/host/Kconfig                |    2 +-
 3 files changed, 22 insertions(+), 1 deletions(-)

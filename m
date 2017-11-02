Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySQNS45hyzDr6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 00:07:20 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA2D5x0u008464
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 09:07:18 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e03jm1q9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 09:07:18 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Thu, 2 Nov 2017 13:07:15 -0000
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/4] fsp2 low level setup
Date: Thu, 2 Nov 2017 16:07:02 +0300
Message-Id: <20171102130706.76056-1-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsp2 board setup with l2 setup and irq handlers
for some critical exceptions.


Ivan Mikhaylov (4):
  44x/fsp2: add fsp2 headers
  44x/fsp2: l2 setup with error clear
  44x/fsp2: tvsense workaround for dd1
  44x/fsp2: add irq error handlers

 arch/powerpc/include/asm/fsp2_reg.h |  272 +++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/fsp2.c   |  254 +++++++++++++++++++++++++++++++++-
 2 files changed, 529 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsp2_reg.h

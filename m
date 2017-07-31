Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLqCQ1y6jzDsPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 05:24:49 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VJNdrA015109
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 15:24:47 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c28cm6jtr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 15:24:47 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 13:24:47 -0600
Subject: Re: [PATCH v3] powerpc/powernv: Enable PCI peer-to-peer
To: mpe@ellerman.id.au
References: <20170717235048.11974-1-fbarrat@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 benh@kernel.crashing.org, clsoto@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 31 Jul 2017 14:24:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170717235048.11974-1-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <28e653f1-77cc-f0f4-2355-d2ec582c338f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

What do we need on this one before we can pull into your -next branch?

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

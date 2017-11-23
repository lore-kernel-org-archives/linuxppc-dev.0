Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yj4pt2tvNzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 14:40:38 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAN3digl127526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:40:34 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2edkhc8v7u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:40:34 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 03:40:32 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [RESEND][PATCH v2] cxl: Check if vphb exists before iterating
 over AFU devices
In-Reply-To: <df2375e6-94fe-b41f-e439-0665de319d3f@linux.vnet.ibm.com>
References: <20171122121744.18697-1-vaibhav@linux.vnet.ibm.com>
 <df2375e6-94fe-b41f-e439-0665de319d3f@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 09:10:23 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760a1k6hk.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
> .. that one is more annoying.
> afu->phb == NULL?

Not sure how I missed that. Thanks for catching this Fred. I have sent a
v3 with the fix.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

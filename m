Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ym7d459nCzDrVC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 13:57:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAS2sPW4021480
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 21:57:42 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2egw30n6ye-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 21:57:42 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 02:57:40 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH v3] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <20171127234158.GA8067@us.ibm.com>
References: <20171127171935.21364-1-vaibhav@linux.vnet.ibm.com>
 <20171127234158.GA8067@us.ibm.com>
Date: Tue, 28 Nov 2017 08:27:32 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efojm7oj.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> We can eliminate the 'else' and be consistent with existing code, if
> we check for error (i.e rc < 0) and return rc. assign_thread_tidr() will
> not return 0, but even if it did, setting the register and thread.tidr
> to 0 should not be a problem.

Thanks for the suggestion Sukadev. I have sent out a v4 at
http://patchwork.ozlabs.org/patch/841937/ with the update.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

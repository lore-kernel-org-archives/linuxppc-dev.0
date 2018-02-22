Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znDHJ0CVTzDq85
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:31:23 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MCUhAq090949
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 07:31:21 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9twxfrvg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 07:31:21 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 12:31:18 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI/AER: Add a null check before eeh_ops->notify_resume
 callback.
In-Reply-To: <20180222115803.21738-1-vaibhav@linux.vnet.ibm.com>
References: <20180222115803.21738-1-vaibhav@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 18:01:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3jl2okw.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


There is already a patch for this issue applied to ppc-next viz commit
521ca5a9859a870e354d1a6b84a6ff ("powerpc/eeh: Add conditional check on
notify_resume"). So please ignore the patch.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yltwC3KFbzDqxp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 04:24:59 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARHNEWH038696
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:24:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2egn99dy24-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:24:56 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 17:24:54 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <8737504c1l.fsf@concordia.ellerman.id.au>
References: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
 <8737504c1l.fsf@concordia.ellerman.id.au>
Date: Mon, 27 Nov 2017 22:54:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8tfmy79.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Success == 0
>
>> +	return rc;
>
> Success == +ve TIDR
>
>>  }
>
> cheers
>

Thanks for reviewing the patch Mpe, I have updated the patch and sent a
v3 with the fix that shouldn't impact the calling convention.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

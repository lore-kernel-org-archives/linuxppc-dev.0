Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BQvW5CNKzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 01:43:03 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5LFYWts091936
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 11:43:01 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jrctr69fr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 11:43:01 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 21 Jun 2018 09:42:53 -0600
Subject: Re: [PATCH 2/2] powerpc/mm: Increase MAX_PHYSMEM_BITS to 128TB with
 SPARSEMEM_VMEMMAP config
To: Balbir Singh <bsingharora@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <20180621083158.30849-1-aneesh.kumar@linux.ibm.com>
 <20180621083158.30849-2-aneesh.kumar@linux.ibm.com>
 <CAKTCnz=qh7fLAuor9YNm5LH5ZKETTP9RjKv_SpR4c=wX37VTEA@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 21 Jun 2018 21:12:45 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=qh7fLAuor9YNm5LH5ZKETTP9RjKv_SpR4c=wX37VTEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dc90c44d-7bff-6154-b797-5658a2feaa4c@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2018 05:02 PM, Balbir Singh wrote:
> On Thu, Jun 21, 2018 at 6:31 PM, Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> We do this only with VMEMMAP config so that our page_to_[nid/section] etc are not
>> impacted.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> Why 128TB, given that it's sparse_vmemmap_extreme by default, why not
> 1PB directly (50 bits)?
> 

That will impact config with VMEMMAP_EXTREME with no real immediate 
benefit. We could possibly make MAX_PHYSMEM_BITS a Kconfig variable. 
s390 do that. Not sure we want to do that.

-aneesh

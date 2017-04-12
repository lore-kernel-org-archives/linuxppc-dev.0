Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2pkn1LYXzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 13:07:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C2whrL077288
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 23:07:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rn513sxh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 23:07:39 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 21:07:39 -0600
Subject: Re: [PATCH 3/9] powerpc/mm: Add _PAGE_DEVMAP for ppc64.
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Oliver O'Halloran" <oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-4-oohall@gmail.com>
 <20170412101922.572b59ca@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 08:37:30 +0530
MIME-Version: 1.0
In-Reply-To: <20170412101922.572b59ca@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <19df521f-ed1b-a351-9141-c3ba11c96cfb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 12 April 2017 05:49 AM, Stephen Rothwell wrote:
> Hi Oliver,
>
> On Wed, 12 Apr 2017 03:42:27 +1000 Oliver O'Halloran <oohall@gmail.com> wrote:
>>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> Add a _PAGE_DEVMAP bit for PTE and DAX PMD entires. PowerPC doesn't
>> currently support PUD faults so we haven't extended it to the PUD
>> level.
>>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>
> This needs Aneesh's Signed-off-by.
>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

-aneesh

Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418GT130wJzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 13:16:05 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5I3EU1j048006
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 23:16:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jp47n0qp9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 23:16:02 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 17 Jun 2018 21:16:01 -0600
Subject: Re: [powerpc/powervmc]kernel BUG at
 arch/powerpc/mm/pgtable-book3s64.c:414!
To: Venkat Rao B <vrbagal1@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
References: <4ca83e8bdd7d9f573a51837fc66a2c45@linux.vnet.ibm.com>
 <87h8m49nb7.fsf@concordia.ellerman.id.au>
 <4d3ad051-2423-3570-7ef6-90f47a83f157@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 18 Jun 2018 08:45:55 +0530
MIME-Version: 1.0
In-Reply-To: <4d3ad051-2423-3570-7ef6-90f47a83f157@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <384d55cf-f2e0-f1be-fb17-587d2f189da7@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2018 01:22 PM, Venkat Rao B wrote:
> 
> 
> On Friday 15 June 2018 07:14 PM, Michael Ellerman wrote:
>> vrbagal1 <vrbagal1@linux.vnet.ibm.com> writes:
>>
>>> Hi,
>>>
>>> Observing kernel bug followed by kernel oops and system reboots, while
>>> running kselftest on Power8 LPAR.
>>>
>>> Machine Details: Power8 LPAR
>>> Git Tree:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>> Commit ID: f5b7769eb0400ec5217a47e41148a9f816ca1f9f
>>> Kernel version: 4.17.0-autotest
>>> GCC version: (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC))
>>>
>>
>> This is fixed by your patch Aneesh?
>>
>> http://patchwork.ozlabs.org/patch/929325/
> 
> Yes, this patch fixes the issue.
> 

I missed adding Reported-by:Venkat Rao B <vrbagal1@linux.vnet.ibm.com> 
and Tested-by:Venkat Rao B <vrbagal1@linux.vnet.ibm.com>

Michael,

Can you add that when applying the patch?

-aneesh

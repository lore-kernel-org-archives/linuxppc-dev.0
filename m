Return-Path: <vrbagal1@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417mfz5fFxzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 17:52:59 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5H7mZ22126107
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 03:52:56 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jnfsanm7y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 03:52:56 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vrbagal1@linux.vnet.ibm.com>;
 Sun, 17 Jun 2018 03:52:55 -0400
Subject: Re: [powerpc/powervmc]kernel BUG at
 arch/powerpc/mm/pgtable-book3s64.c:414!
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, aneesh.kumar@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>
References: <4ca83e8bdd7d9f573a51837fc66a2c45@linux.vnet.ibm.com>
 <87h8m49nb7.fsf@concordia.ellerman.id.au>
From: Venkat Rao B <vrbagal1@linux.vnet.ibm.com>
Date: Sun, 17 Jun 2018 13:22:49 +0530
MIME-Version: 1.0
In-Reply-To: <87h8m49nb7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4d3ad051-2423-3570-7ef6-90f47a83f157@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 15 June 2018 07:14 PM, Michael Ellerman wrote:
> vrbagal1 <vrbagal1@linux.vnet.ibm.com> writes:
> 
>> Hi,
>>
>> Observing kernel bug followed by kernel oops and system reboots, while
>> running kselftest on Power8 LPAR.
>>
>> Machine Details: Power8 LPAR
>> Git Tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> Commit ID: f5b7769eb0400ec5217a47e41148a9f816ca1f9f
>> Kernel version: 4.17.0-autotest
>> GCC version: (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC))
>>
> 
> This is fixed by your patch Aneesh?
> 
> http://patchwork.ozlabs.org/patch/929325/

Yes, this patch fixes the issue.

Regards,
Venkat

> 
> cheers
> 

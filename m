Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL3MH0nPqzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 11:27:54 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7Q1P9Bb130802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:27:51 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2521btm73y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:27:51 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 06:57:48 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E22533940061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:57:46 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7Q1RkRB39583794
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:57:46 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7Q1RjFI009124
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:57:46 +0530
Subject: Re: [RFC PATCH v3 08/12] powerpc: Introduce new mask bit for
 soft_enabled
To: Nicholas Piggin <npiggin@gmail.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472106603-23336-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20160825170549.030a4387@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 06:57:41 +0530
MIME-Version: 1.0
In-Reply-To: <20160825170549.030a4387@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2dd38984-a5cb-07d1-12d8-adffb7a549b8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 25 August 2016 12:35 PM, Nicholas Piggin wrote:
> On Thu, 25 Aug 2016 11:59:59 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>> index c19169ac1fbb..e457438c6fdf 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -32,6 +32,7 @@
>>    */
>>   #define IRQ_DISABLE_MASK_NONE		0
>>   #define IRQ_DISABLE_MASK_LINUX		1
>> +#define IRQ_DISABLE_MASK_PMU		2
>>   
>>   #endif /* CONFIG_PPC64 */
> This bit belongs in patch 10, I think?
Yes. I had that in Patch 10, but then since this patch talks abt making 
the soft_enabled
as a mask, having the third value here made sense. But I can move back 
to patch 10.

Maddy

>

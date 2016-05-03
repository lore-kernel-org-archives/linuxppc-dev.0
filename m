Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWW94qQRzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:13 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E3E053578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:08 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436U0lY63242316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:08 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436TawM026897
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:36 +1000
Message-ID: <57284536.8040202@linux.vnet.ibm.com>
Date: Tue, 03 May 2016 11:59:10 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] powerpc/powernv: Add platform support for stop
 instruction
References: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1461246599-6098-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462253150.4115.11.camel@neuling.org>
In-Reply-To: <1462253150.4115.11.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/03/2016 10:55 AM, Michael Neuling wrote:
> 
>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>> index df4fb5f..a4739a1 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -205,6 +205,7 @@ enum {
>>  #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
>>  #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
>>  #define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
>> +#define CPU_FTR_STOP_INST		LONG_ASM_CONST(0x4000000000000000)
> 
> In general, we are putting all the POWER9 features under CPU_FTR_ARCH_300.
> Is there a reason you need this separate bit?
> 

No I don't need a separate bit, I'll use CPU_FTR_ARCH_300.

Thanks,
Shreyas

> CPU_FTR bits are fairly scarce these days.
> 
> Mikey
> 

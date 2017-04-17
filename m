Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5r1M5Wr7zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 11:15:51 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H1EbKr134779
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 21:15:45 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ufp16f95-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 21:15:44 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 06:45:41 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3H1Fdlj11206908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 06:45:39 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3H1Fc77010678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 06:45:39 +0530
Subject: Re: [PATCH v7 01/11] powerpc: move set_soft_enabled() and rename
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
References: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491984040-28801-2-git-send-email-maddy@linux.vnet.ibm.com>
 <871ssv9awh.fsf@concordia.ellerman.id.au>
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 17 Apr 2017 06:45:37 +0530
MIME-Version: 1.0
In-Reply-To: <871ssv9awh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <daf92c3c-6d6a-5f83-f610-405122231b3b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 14 April 2017 04:24 AM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>> @@ -269,7 +263,7 @@ notrace void arch_local_irq_restore(unsigned long en)
>>   	replay = __check_irq_replay();
>>   
>>   	/* We can soft-enable now */
>> -	set_soft_enabled(IRQ_DISABLE_MASK_NONE);
>> +	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
> In upstream we don't have any of the IRQ_DISABLE_MASK_* flags.
>
> So something's gotten a bit messed up here, did you forget to send a
> patch, or are they out of order or something?

Oops. Yes i missed the first patch in the series.
Missed at format-patch step. My bad

>
> I spent 10 minutes with quilt trying to massage it but pretty much every
> patch seems to be patching code that I don't have.

Sorry. Will resend as v8.
Maddy

> cheers
>

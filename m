Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scw8S446szDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:55:04 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5rGWp050683
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:55:02 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25gxqhwrkm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:55:02 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 11:24:59 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 554C8E005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 11:24:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J5st5852035752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 11:24:55 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J5sqgI001819
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 11:24:54 +0530
Subject: Re: [PATCH 08/13] powerpc: Add new _EXCEPTION_PROLOG_1 macro
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916201242.7b452f42@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 11:24:51 +0530
MIME-Version: 1.0
In-Reply-To: <20160916201242.7b452f42@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f1a0a1c8-6b98-dfe0-f67c-6585e37b321d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 03:42 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:31:58 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> To support addition of "bitmask" to MASKABLE_* macros,
>> factor out the EXCPETION_PROLOG_1 macro.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Really minor nit, but as a matter of readability of the series,
> would you consider moving this next to patch 10 where it's used,
> if you submit again?
Yes sure. Make sense. Will do it.

Maddy

>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>

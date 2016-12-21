Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk0MN74NLzDwVk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:22:24 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBL3JDEW091621
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 22:22:22 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27fcudf3sh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 22:22:21 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 13:22:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A0E412BB0061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:22:12 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBL3MCA031785000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:22:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBL3MBnT002017
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:22:12 +1100
Subject: Re: [PATCH v4 01/12] powerpc: Add #defs for paca->soft_enabled flags
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-2-git-send-email-maddy@linux.vnet.ibm.com>
 <f69a3c42-b795-0c14-f812-0ff45489146f@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 08:52:09 +0530
MIME-Version: 1.0
In-Reply-To: <f69a3c42-b795-0c14-f812-0ff45489146f@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7fabbd11-7001-4397-fdea-c1863a0e1c76@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 20 December 2016 01:01 PM, Balbir Singh wrote:
> <snip>
>>
>> +/*
>> + * flags for paca->soft_enabled
>> + */
>> +#define IRQ_DISABLE_MASK_NONE    1
>> +#define IRQ_DISABLE_MASK_LINUX    0
>> +
>
> Isn't one just the complement of the other?
>
Yes. But these are initial cleanup patchs and in subsequent
patches we will reuse these as mask bits instead of flag.

Maddy


> Balbir
>

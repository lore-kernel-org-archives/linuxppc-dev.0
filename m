Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk4BL12bpzDwHX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 17:14:49 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBL6ESOS105355
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 01:14:48 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27fgs54nra-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 01:14:47 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 11:44:44 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E51F6E0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 11:45:22 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBL6Eenk35389500
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 11:44:40 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBL6Ed3I028700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 11:44:40 +0530
Subject: Re: [PATCH v4 07/12] powerpc: Add support to take additional
 parameter in MASKABLE_* macro
To: Nicholas Piggin <npiggin@gmail.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-8-git-send-email-maddy@linux.vnet.ibm.com>
 <20161220121412.213b9ca0@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 11:44:39 +0530
MIME-Version: 1.0
In-Reply-To: <20161220121412.213b9ca0@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4ce5a443-cf77-503f-a84b-a718349dd1da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 20 December 2016 08:06 AM, Nicholas Piggin wrote:
> On Mon, 19 Dec 2016 13:37:03 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> To support addition of "bitmask" to MASKABLE_* macros,
>> factor out the EXCPETION_PROLOG_1 macro.
>>
>> Currently soft_enabled is used as the flag to determine
>> the interrupt state. Patch extends the soft_enabled
>> to be used as a mask instead of a flag.
> This is really the core part of the patch -- after reversing the
> soft_enable logic to be a disable boolean, now it's being extended
> to be a disable mask. The exception macro changes just allow an
> interrupt type bit to be passed in later.
>
> I should have picked it up earlier, but if you do end up submitting
> another version, perhaps consider splitting the disable mask change
> and putting it after patch 5.
Yes will do that. Make sense.

Maddy

>
> Thanks,
> Nick
>

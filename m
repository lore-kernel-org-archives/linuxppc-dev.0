Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNTcc2mk0zDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 17:18:24 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F6E6Q4072499
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:18:21 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28m2rsh7rd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:18:21 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 11:48:13 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9BD2E125805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 11:48:13 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1F6I8b428704802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 11:48:08 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1F6IAiN025333
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 11:48:10 +0530
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
 <874lzw9h2l.fsf@linux.vnet.ibm.com>
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 11:48:04 +0530
MIME-Version: 1.0
In-Reply-To: <874lzw9h2l.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ae53e4ca-9d88-9dcc-4c44-0db154428151@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 15 February 2017 10:38 AM, Stewart Smith wrote:
> Mukesh Ojha <mukesh02@linux.vnet.ibm.com> writes:
>
>> Converts all the return explicit number to a more proper IRQ_HANDLED,
>> which looks proper incase of interrupt handler returning case.
>>
>> Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
>> Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/opal-dump.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
> Should also have:
> Fixes: 8034f715f ("powernv/opal-dump: Convert to irq domain")
>
> ?
>

Yeah .. i should have mentioned which patch missed these changes.

-Mukesh

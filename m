Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTNWY4jT9zDqml
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 01:45:45 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUEiK3i080015
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 09:45:43 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2720ft92e3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 09:45:43 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 20:15:38 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AF32AE005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:15:58 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAUEjYbE27787402
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:15:34 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAUEjXor026838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:15:34 +0530
Subject: Re: [PATCH v3 3/4] powerpc/perf: PowerISA v3.0 raw event format
 encoding
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1480296076-28880-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1480296076-28880-4-git-send-email-maddy@linux.vnet.ibm.com>
 <87bmwyrjgv.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 20:15:17 +0530
MIME-Version: 1.0
In-Reply-To: <87bmwyrjgv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <32855b39-76c5-7bc2-cc73-9e25c4fb13a7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 29 November 2016 10:06 AM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>
>> Patch to update the PowerISA v3.0 raw event encoding format
>> information and add support for the same in Power9-pmu.c.
> I'm not sure if calling this the "PowerISA v3.0" encoding is right. It's
> not actually specified in the ISA anywhere right?

Yes will make the changes.

Maddy

>
> Maybe it should just be the "P9 encoding" ?
>
> Though admittedly that is slightly confusing because P9 DD1 doesn't
> implement it.
>
> cheers
>

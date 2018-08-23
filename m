Return-Path: <srs0=gqm2=lg=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x5mW3gkpzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 00:06:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41x5mV4HRdz8wRV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 00:06:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41x5mT5B7Cz9s8f
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2018 00:06:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7NE43Gx156147
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 10:05:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m1uf1829a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 10:05:59 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Aug 2018 15:05:57 +0100
Subject: Re: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
 <87d0u9lgyt.fsf@concordia.ellerman.id.au>
 <10dfea17-e98b-7a46-6dba-b222a6cf0c96@linux.vnet.ibm.com>
 <871sapl24w.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 23 Aug 2018 19:35:51 +0530
MIME-Version: 1.0
In-Reply-To: <871sapl24w.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <09a2ca4e-9c51-9214-f3e0-ab207acf1536@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2018 05:35 PM, Michael Ellerman wrote:
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> On 08/23/2018 12:14 PM, Michael Ellerman wrote:
>>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>>>
>>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>>
>>>> With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
>>>> during MCE recovery path.),
>>>
>>> That commit description is wrong, I'll fix it up.
>>
>> Ouch.. My bad.. :-(
> 
> To make it easier to get right, if you don't already, add these to your
> ~/.gitconfig:
> 
> [pretty]
> 	fixes = Fixes: %h (\"%s\")
> 	quote = %h (\"%s\")
> 
> 
> And then you can do:
> 
> $ git log -1 --pretty=quote e7e81847478 
> e7e81847478b ("powerpc/64s: move machine check SLB flushing to mm/slb.c")
> 
> $ git log -1 --pretty=fixes e7e81847478 
> Fixes: e7e81847478b ("powerpc/64s: move machine check SLB flushing to mm/slb.c")

Thank you very much :-) This is going to be very handy...

-Mahesh.

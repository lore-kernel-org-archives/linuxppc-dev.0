Return-Path: <srs0=8qt9=mg=linux.vnet.ibm.com=maddy@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JZwQ66kdzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 17:05:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42JZwQ5V1hz8xKT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 17:05:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42JZwQ1jM2z9sB4
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2018 17:05:25 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O741UO114597
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2018 03:05:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mpu70g2fu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2018 03:05:23 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 24 Sep 2018 08:05:21 +0100
Subject: Re: [PATCH] powerpc/perf: Add missing break in
 power7_marked_instr_event()
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 maddy@linux.ibm.com, paulus@samba.org
References: <20180920094111.4125-1-mpe@ellerman.id.au>
 <e1868207-7dd4-e6cc-0fce-04e0fd1e5edc@linux.vnet.ibm.com>
 <20180920144715.GA23155@gate.crashing.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 24 Sep 2018 12:35:16 +0530
MIME-Version: 1.0
In-Reply-To: <20180920144715.GA23155@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8f147e4f-321b-d730-0a0a-f6cee8254dd0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 20 September 2018 08:17 PM, Segher Boessenkool wrote:
> On Thu, Sep 20, 2018 at 03:29:22PM +0530, Madhavan Srinivasan wrote:
>> On Thursday 20 September 2018 03:11 PM, Michael Ellerman wrote:
>>> In power7_marked_instr_event() there is a switch case that is missing
>>> a break or an explicit fallthrough, it's not immediately clear which
>>> it should be.
>> Just curious to know, how did you find this. Static code checker compiled
>> or any specific compiler warnings or just by code read?
> Newer GCC warns about suspicious fallthroughs (-Wimplicit-fallthrough,
> which is in -Wextra).
>

Nice good to know.

Maddy


> Segher
>

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stTg15wCgzDskf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 18:50:05 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3stTg11Nllz9sC7
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2016 18:50:04 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9B7n85q075853
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2016 03:50:02 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 260k0345qn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2016 03:50:02 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 11 Oct 2016 01:50:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Oliver O'Halloran" <oohall@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org,
 Chris Smart <chris@distroguy.com>
Subject: Re: [PATCH] Fix "ibm,processor-radix-AP-encodings"
In-Reply-To: <87fuo35tdl.fsf@concordia.ellerman.id.au>
References: <0612c46e-7e1b-3729-d84f-cefa886abb6d@gmail.com>
 <877f9wbv6j.fsf@linux.vnet.ibm.com>
 <CAOSf1CE2RJ2X_cB8nZz3UziFURqrqA7aLV+GVySY6k+8KPYTiA@mail.gmail.com>
 <87fuo35tdl.fsf@concordia.ellerman.id.au>
Date: Tue, 11 Oct 2016 13:19:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgxvb9zy.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Oliver O'Halloran <oohall@gmail.com> writes:
>
>> On Wed, Sep 28, 2016 at 12:43 PM, Aneesh Kumar K.V
>> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>> Balbir Singh <bsingharora@gmail.com> writes:
>>>
>>>> The top 3 bits of the lower order byte should contain the
>>>> AP encoding, we assume the top 3 bits of the MSB.
>>
>> Balbir, could you reword this so it says "Currently we wrongly assume
>> <blah>" or similar. The current commit message made me think you were
>> changing it to look at the top 3 bits of the MSB rather than changing
>> it look at the LSB.
>
> Yeah please reword it to describe what the current code does, why it's
> incorrect, and how we are fixing it.
>

I have an updated patch for this, which redo the AP-encoding parsing
based on spec update. Wil send it to the list once we finalize the
details

-aneesh

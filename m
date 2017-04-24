Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBLTx0Q73zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:22:44 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3O9IU33028519
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:22:42 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a0mqg50q7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:22:42 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 03:22:40 -0600
Subject: Re: [PATCH] powerpc/64s: use ibm,
 tlbiel-congruence-classes-(hash|radix) dt property
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <8737cy2ozz.fsf@skywalker.in.ibm.com>
 <87a876rwpe.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 14:52:30 +0530
MIME-Version: 1.0
In-Reply-To: <87a876rwpe.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <121d8153-35b0-2bbc-d61d-8310568ce2dd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 24 April 2017 02:47 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>> tlbiel instruction with IS!=0 on POWER7 and later Book3s CPUs invalidate
>>> TLBs belonging to a specified congruence class. In order to operate on
>>> the entire TLB, all congruence classes must be specified, requiring a
>>> software loop.
> ...
>>
>> This may need a rebase if mpe is going to take https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/157130.html
>
> I would but it says "Not yet tested" :)
>

Anton replied with test results.

-aneesh

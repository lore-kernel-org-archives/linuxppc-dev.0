Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3HMw06n4zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 19:37:00 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r3HMv5CKKz9s9W
 for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2016 19:36:59 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 9 May 2016 19:36:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7DCBE3578052
 for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2016 19:36:56 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u499amjU11731226
 for <linuxppc-dev@ozlabs.org>; Mon, 9 May 2016 19:36:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u499aOJ4019010
 for <linuxppc-dev@ozlabs.org>; Mon, 9 May 2016 19:36:24 +1000
Subject: Re: [3/3] powerpc/fadump: add support for fadump_nr_cpus= parameter
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3r1wGk6H7Yz9t3k@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <573059FE.7080706@linux.vnet.ibm.com>
Date: Mon, 9 May 2016 15:05:58 +0530
MIME-Version: 1.0
In-Reply-To: <3r1wGk6H7Yz9t3k@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/07/2016 09:42 AM, Michael Ellerman wrote:
> On Fri, 2016-06-05 at 11:51:08 UTC, Hari Bathini wrote:
>> Kernel parameter 'nr_cpus' can be used to limit the maximum number
>> of processors that an SMP kernel could support. This patch extends
>> this to fadump by introducing 'fadump_nr_cpus' parameter that can
>> help in booting fadump kernel on a lower memory footprint.
> Is there really no other way to do this? I really hate adding new, single use
> only command line parameters.

Hmmm.. only alternative I can think about is enforcing a certain nr_cpu_ids
value whenever fadump is active, but that doesn't sound right..
Any suggestions?

Thanks
Hari

> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

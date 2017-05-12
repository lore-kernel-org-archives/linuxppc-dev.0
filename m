Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPTsG0YLDzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 22:33:05 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4CCSiZ5127122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 08:32:52 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2acpt14b6c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 08:32:52 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 12 May 2017 08:32:50 -0400
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
References: <20170511112441.30287-1-npiggin@gmail.com>
 <9b214f48-9d56-440c-f6d0-6308ff47305d@us.ibm.com>
 <87inl6butu.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 12 May 2017 07:32:46 -0500
MIME-Version: 1.0
In-Reply-To: <87inl6butu.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7f6307f3-6b5a-f655-a93c-3eb4bb1c2062@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2017 10:46 PM, Michael Ellerman wrote:
> Paul Clarke <pc@us.ibm.com> writes:
>> On 05/11/2017 06:24 AM, Nicholas Piggin wrote:
>>> Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
>>> feature discovery, and fall back to the "cputable" based version.
>>
>> This boat has already sailed, I think, but "ftrs"?
> 
> What you think vowels grow on trees! :)

At least you're using lower-case, which takes less space.  ;-)

>> Was it too difficult to type "features"?

I see "ftrs" and think "footers".

> For the command line option we could spell out features.
> 
> But should we also expand "dt", and "cpu" ?
> 
> device_tree_central_processing_unit_features=off

I'm not the biggest fan of "dt" ("devtree", anyone?), but that's certainly established.

So _that's_ what "cpu" stands for!  ;-)

> :P
> 
>> This seems like something that should be easy and intuitive to find
>> and understand.
> 
> Maybe. Ideally no one will ever use it, certainly not end users, it's
> primarily intended for developers doing bring-up.

I'm a developer, and I like to be able to understand something at a glance.  (Hmm, what are "CPU footers"?)

:-P

PC

Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3D6CF2C00CE
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:56:35 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 19:56:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 582E23578047
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:56:29 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2L9a73K9896332
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:36:07 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2L9uSro026493
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:56:28 +1100
Message-ID: <532C0CBD.1060904@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 15:26:13 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/5] powernv, cpufreq:Add per-core locking to serialize
 frequency transitions
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==Lzeatp=7BoxuSH4PfxXqWqpHJ_KcwWdXXsFAftxTMCQ@mail.gmail.com>
In-Reply-To: <CAOh2x==Lzeatp=7BoxuSH4PfxXqWqpHJ_KcwWdXXsFAftxTMCQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/21/2014 02:12 PM, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
>> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
>>
>> On POWER systems, the CPU frequency is controlled at a core-level and
>> hence we need to serialize so that only one of the threads in the core
>> switches the core's frequency at a time.
> 
> Probably you don't need this anymore.
> 
> https://lkml.org/lkml/2014/3/21/23
> 

Agreed.

Regards,
Srivatsa S. Bhat

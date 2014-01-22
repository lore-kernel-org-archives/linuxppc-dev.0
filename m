Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F2E42C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 20:38:43 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 Jan 2014 19:38:42 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0D9F52CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 20:38:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0M9JQgF56492270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 20:19:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0M9cbnX015567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 20:38:37 +1100
Message-ID: <52DF914B.2060308@linux.vnet.ibm.com>
Date: Wed, 22 Jan 2014 15:07:15 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/8] Add support for PowerPC Hypervisor supplied
 performance counters
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1390354379.11104.3.camel@concordia>
In-Reply-To: <1390354379.11104.3.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2014 07:02 AM, Michael Ellerman wrote:
> On Thu, 2014-01-16 at 15:53 -0800, Cody P Schafer wrote:
>> These patches add basic pmus for 2 powerpc hypervisor interfaces to obtain
>> performance counters: gpci ("get performance counter info") and 24x7.
>>
>> The counters supplied by these interfaces are continually counting and never
>> need to be (and cannot be) disabled or enabled. They additionally do not
>> generate any interrupts. This makes them in some regards similar to software
>> counters, and as a result their implimentation shares some common code (which
>> an initial patch exposes) with the sw counters.
> 
> Hi Cody,
> 
> Can you please add some more explanation of this series.
> 
> In particular why do we need two new PMUs, and how do they relate to each
> other?
> 
> And can you add an example of how I'd actually use them using perf.
> 

Yeah, agreed.

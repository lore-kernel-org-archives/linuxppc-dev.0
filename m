Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xG6Y5RzF2M4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:22 +1100 (AEDT)
In-Reply-To: <1520164588-19167-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/3] powerpc/perf: Infrastructure to support addition of
 blacklisted events
Message-Id: <40B8xG36q1z9s0q@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-03-04 at 11:56:26 UTC, Madhavan Srinivasan wrote:
> Introduce code to support addition of blacklisted events for a
> processor version. A 'pointer' and 'int' variable to hold the
> number of events are added to 'struct power_pmu', along with a
> generic function to loop through the list to validate the given
> event. Generic function 'is_event_blacklisted' is called in
> power_pmu_event_init() to detect and reject early.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b58064da046243f0c988afd939997e

cheers

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 192751A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 19:48:39 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDEA8140142
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 19:48:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 12 Mar 2015 18:48:38 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 96F762BB0054
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 19:48:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2C8mKOQ44630022
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 19:48:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2C8lsuG015162
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 19:47:55 +1100
Message-ID: <55015294.40709@linux.vnet.ibm.com>
Date: Thu, 12 Mar 2015 14:17:16 +0530
From: maddy <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [RFC PATCH 4/7]powerpc/powernv: Add OPAL support for Nest pmu
References: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1426079233-16720-5-git-send-email-maddy@linux.vnet.ibm.com>
 <m31tkvuopz.fsf@oc8180480414.ibm.com>
In-Reply-To: <m31tkvuopz.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 12 March 2015 04:27 AM, Stewart Smith wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>> Nest Counters can be configured via PORE Engine and OPAL
>> provides an interface call to it. PORE Engine also does the
>> work of moving the counter data to memory.
> Do you have the associated skiboot patch that implements this firmware
> call? I haven't seen it on the skiboot list yet :)
Hi Stewart,

     OPAL side code is under-developement. Will post the patches soon to 
the skiboot mailing list.

Regards
Maddy

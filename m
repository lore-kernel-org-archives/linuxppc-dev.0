Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 068561A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:28:26 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7D1A1401DE
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:28:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 16:28:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ADE2A2CE805A
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:28:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7C6SEOJ65929312
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:28:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7C6RmY1015511
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:27:49 +1000
Message-ID: <55CAE753.8000807@linux.vnet.ibm.com>
Date: Wed, 12 Aug 2015 11:57:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH 8/8] powerpc/xmon: Add some more elements to the existing
 PACA dump list
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1438153805-31828-8-git-send-email-khandual@linux.vnet.ibm.com>
 <1439359555.27815.1.camel@ellerman.id.au>
In-Reply-To: <1439359555.27815.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2015 11:35 AM, Michael Ellerman wrote:
> On Wed, 2015-07-29 at 12:40 +0530, Anshuman Khandual wrote:
>> This patch adds a set of new elements to the existing PACA dump list
>> inside an xmon session which can be listed below improving the overall
>> xmon debug support.
>>
>> (1) hmi_event_available
>> (2) dscr_default
>> (3) vmalloc_sllp
>> (4) slb_cache_ptr
>> (5) sprg_vdso
>> (6) tm_scratch
>> (7) core_idle_state_ptr
>> (8) thread_idle_state
>> (9) thread_mask
>> (10) slb_shadow
>> (11) pgd
>> (12) kernel_pgd
>> (13) tcd_ptr
>> (14) mc_kstack
>> (15) crit_kstack
>> (16) dbg_kstack
>> (17) user_time
>> (18) system_time
>> (19) user_time_scaled
>> (20) starttime
>> (21) starttime_user
>> (22) startspurr
>> (23) utime_sspurr
>> (24) stolen_time
> 
> Adding these makes the paca display much longer than 24 lines. I know in
> general we don't worry too much about folks on 80x24 green screens, but it's
> nice if xmon works OK on those. Or on virtual consoles that don't scroll for
> whatever reason.
> 
> So I'm going to hold off on this one until we have a way to display some of the
> paca. I have an idea for that and will send a patch if it works.
> 

Sure, if you believe that is the best thing to do at the moment.

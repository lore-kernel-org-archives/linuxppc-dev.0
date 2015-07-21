Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F09601A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:49:01 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C81E314029D
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:49:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 21:49:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 96E653578048
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:48:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6LBmouc55247072
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:48:58 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6LBmPAY022173
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:48:26 +1000
Message-ID: <55AE3178.5010500@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 17:18:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [RFC, 8/8] powerpc/xmon: Add some more elements to the existing
 PACA dump list
References: <20150721100816.EE0AD14076E@ozlabs.org>
In-Reply-To: <20150721100816.EE0AD14076E@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 03:38 PM, Michael Ellerman wrote:
> On Tue, 2015-21-07 at 06:58:46 UTC, Anshuman Khandual wrote:
>> > From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
>> > 
>> > This patch adds some more elements to the existing PACA dump list
>> > inside a xmon session which can be listed here.
>> > 
>> > 	- hmi_event_available
>> > 	- dscr_default
>> > 	- vmalloc_sllp
>> > 	- slb_cache_ptr
>> > 	- sprg_vdso
>> > 	- tm_scratch
>> > 	- core_idle_state_ptr
>> > 	- thread_idle_state
>> > 	- thread_mask
> This is probably OK, except you broke the ppc64e build again.

Will fix it up while sending this as a patch series. Thanks for
the quick review of the series.

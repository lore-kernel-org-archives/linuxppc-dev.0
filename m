Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwRQf2F4QzDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:15:38 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 16:15:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 15A073578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:15:14 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3S6Ej4i1311056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:15:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3S6ELlE010595
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:14:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 35/68] powerpc/mm: Abstraction for switch_mmu_context
In-Reply-To: <5718DFD2.9070500@gmail.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-36-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5718DFD2.9070500@gmail.com>
Date: Thu, 28 Apr 2016 11:43:41 +0530
Message-ID: <87r3dqtg4q.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 09/04/16 16:13, Aneesh Kumar K.V wrote:
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/mmu_context.h | 25 +++++++++++++------------
>>  arch/powerpc/kernel/swsusp.c           |  2 +-
>>  arch/powerpc/mm/mmu_context_nohash.c   |  3 ++-
>>  drivers/cpufreq/pmac32-cpufreq.c       |  2 +-
>>  drivers/macintosh/via-pmu.c            |  4 ++--
>>  5 files changed, 19 insertions(+), 17 deletions(-)
>
> Why do we need to pass the task? Changelog --?
>

switch_slb need that.

-aneesh

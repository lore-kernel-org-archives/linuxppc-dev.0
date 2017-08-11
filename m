Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVSQ4DGDzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:14:14 +1000 (AEST)
Subject: Re: [v6 14/15] mm: optimize early system hash allocations
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-15-git-send-email-pasha.tatashin@oracle.com>
 <20170811130541.GM30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <8da9321c-769c-3319-8c02-3c91d86b221e@oracle.com>
Date: Fri, 11 Aug 2017 12:13:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170811130541.GM30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Clients can call alloc_large_system_hash() with flag: HASH_ZERO to specify
>> that memory that was allocated for system hash needs to be zeroed,
>> otherwise the memory does not need to be zeroed, and client will initialize
>> it.
>>
>> If memory does not need to be zero'd, call the new
>> memblock_virt_alloc_raw() interface, and thus improve the boot performance.
>>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> OK, but as mentioned in the previous patch add memblock_virt_alloc_raw
> in this patch.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Ok I will merge them.

Thank you,
Pasha

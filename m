Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWGvT6VrKzDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:40:21 +1000 (AEST)
Subject: Re: [v6 04/15] mm: discard memblock data later
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, Mel Gorman <mgorman@suse.de>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
 <42a04441-47ad-2fa0-ca3c-784c717213f7@oracle.com>
 <20170814113445.GE19063@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <aac7b5f1-5c5e-e716-af49-bc150449ddbc@oracle.com>
Date: Mon, 14 Aug 2017 09:39:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170814113445.GE19063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> #ifdef CONFIG_MEMBLOCK in page_alloc, or define memblock_discard() stubs in
>> nobootmem headfile.
> 
> This is the standard way to do this. And it is usually preferred to
> proliferate ifdefs in the code.

Hi Michal,

As you suggested, I sent-out this patch separately. If you feel 
strongly, that this should be updated to have stubs for platforms that 
do not implement memblock, please send a reply to that e-mail, so those 
who do not follow this tread will see it. Otherwise, I can leave it as 
is, page_alloc file already has a number memblock related ifdefs all of 
which can be cleaned out once every platform implements it (is it even 
achievable?)

Thank you,
Pasha

Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWGpr5TLzzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:36:20 +1000 (AEST)
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
 <6366171f-1a30-2faa-d776-01983fcb5a00@oracle.com>
 <20170811160436.GS30811@dhcp22.suse.cz>
 <a63eb223-455f-ae57-122f-7b2655e3de26@oracle.com>
 <20170814113652.GF19063@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <3c223cac-68f8-f810-38dd-4ff580048e63@oracle.com>
Date: Mon, 14 Aug 2017 09:35:16 -0400
MIME-Version: 1.0
In-Reply-To: <20170814113652.GF19063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> OK, I will post it separately. No it does not depend on the rest, but the
>> reset depends on this. So, I am not sure how to enforce that this comes
>> before the rest.
> 
> Andrew will take care of that. Just make it explicit that some of the
> patch depends on an earlier work when reposting.

Ok.

>> Yes, they said that the problem was bisected down to this patch. Do you know
>> if there is a way to submit a patch to this test robot?
> 
> You can ask them for re testing with an updated patch by replying to
> their report. ANyway I fail to see how the change could lead to this
> patch.

I have already done that. Anyway, I think it is unrelated. I have used 
their scripts to test the patch alone, with number of elements in 
memblock array reduced down to 4. Verified that my freeing code is 
called, and never hit the problem that they reported.

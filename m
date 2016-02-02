Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C81791A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 09:37:57 +1100 (AEDT)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 2 Feb 2016 22:37:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C955E2190023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 22:37:38 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12MbpLK5767474
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 22:37:51 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12Mbopq030730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 15:37:51 -0700
Subject: Re: [PATCH v3 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
To: Andrew Morton <akpm@linux-foundation.org>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
 <1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
 <alpine.DEB.2.10.1601271414180.23510@chino.kir.corp.google.com>
 <56A9E3D1.3090001@de.ibm.com>
 <alpine.DEB.2.10.1601281500160.31035@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1602021351290.4977@chino.kir.corp.google.com>
 <56B12560.4010201@de.ibm.com>
 <20160202142157.1bfc6f81807faaa026957917@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <56B12FBE.3070909@de.ibm.com>
Date: Tue, 2 Feb 2016 23:37:50 +0100
MIME-Version: 1.0
In-Reply-To: <20160202142157.1bfc6f81807faaa026957917@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 11:21 PM, Andrew Morton wrote:
> On Tue, 2 Feb 2016 22:53:36 +0100 Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>>>> I don't think we should have a CONFIG_DEBUG_PAGEALLOC that does some stuff 
>>>> and then a commandline parameter or CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT 
>>>> to enable more stuff.  It should either be all enabled by the commandline 
>>>> (or config option) or split into a separate entity.  
>>>> CONFIG_DEBUG_PAGEALLOC_LIGHT and CONFIG_DEBUG_PAGEALLOC would be fine, but 
>>>> the current state is very confusing about what is being done and what 
>>>> isn't.
>>>>
>>>
>>> Ping?
>>>
>> https://lkml.org/lkml/2016/1/29/266 
> 
> That's already in linux-next so I can't apply it.
> 
> Well, I can, but it's a hassle.  What's happening here?

I pushed it on my tree for kbuild testing purposes some days ago. 
Will drop so that it can go via mm.

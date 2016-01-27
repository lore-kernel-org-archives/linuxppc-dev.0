Return-Path: <rientjes@google.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 150141A1A0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 09:18:33 +1100 (AEDT)
Received: by mail-pa0-x236.google.com with SMTP id uo6so11673284pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 14:18:32 -0800 (PST)
Date: Wed, 27 Jan 2016 14:18:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Subject: Re: [PATCH v3 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
In-Reply-To: <1453889401-43496-4-git-send-email-borntraeger@de.ibm.com>
Message-ID: <alpine.DEB.2.10.1601271418190.23510@chino.kir.corp.google.com>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
 <1453889401-43496-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linuxppc-dev.linuxppc.org>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 1MB/2GB pages as well as to print
> the current setting in dump_stack.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>

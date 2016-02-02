Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 922F01A0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 09:22:01 +1100 (AEDT)
Date: Tue, 2 Feb 2016 14:21:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Subject: Re: [PATCH v3 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
Message-Id: <20160202142157.1bfc6f81807faaa026957917@linux-foundation.org>
In-Reply-To: <56B12560.4010201@de.ibm.com>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
 <1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
 <alpine.DEB.2.10.1601271414180.23510@chino.kir.corp.google.com>
 <56A9E3D1.3090001@de.ibm.com>
 <alpine.DEB.2.10.1601281500160.31035@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1602021351290.4977@chino.kir.corp.google.com>
 <56B12560.4010201@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2 Feb 2016 22:53:36 +0100 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> >> I don't think we should have a CONFIG_DEBUG_PAGEALLOC that does some stuff 
> >> and then a commandline parameter or CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT 
> >> to enable more stuff.  It should either be all enabled by the commandline 
> >> (or config option) or split into a separate entity.  
> >> CONFIG_DEBUG_PAGEALLOC_LIGHT and CONFIG_DEBUG_PAGEALLOC would be fine, but 
> >> the current state is very confusing about what is being done and what 
> >> isn't.
> >>
> > 
> > Ping?
> > 
> https://lkml.org/lkml/2016/1/29/266 

That's already in linux-next so I can't apply it.

Well, I can, but it's a hassle.  What's happening here?

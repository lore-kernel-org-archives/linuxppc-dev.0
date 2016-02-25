Return-Path: <hughd@google.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 831971A0406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:36:24 +1100 (AEDT)
Received: by mail-pf0-x233.google.com with SMTP id x65so26495595pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 21:36:24 -0800 (PST)
Date: Wed, 24 Feb 2016 21:36:13 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Problems with swapping in v4.5-rc on POWER
In-Reply-To: <1456373550.30375.3.camel@ellerman.id.au>
Message-ID: <alpine.LSU.2.11.1602242131480.6876@eggly.anvils>
References: <alpine.LSU.2.11.1602241716220.15121@eggly.anvils>
 <1456373550.30375.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Feb 2016, Michael Ellerman wrote:
> 
> I do run tests on G5, but obviously not rigorously enough. I kicked off a few
> kernel builds on mine and it survived, though once it hits swap it's almost
> unusably slow. I'll leave it running overnight and see if I hit anything.

Oh yes, I'd forgotten how unusably slow: I tend to forget that I slipped an
SSD in there some while back, just for the swapping: slow, but not unusable.

Thanks, I'm hoping you will be able to reproduce it yourself.

Hugh

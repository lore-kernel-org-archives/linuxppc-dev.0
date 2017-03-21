Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnm9T5xlxzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 08:27:09 +1100 (AEDT)
Message-ID: <1490131572.2504.56.camel@kernel.crashing.org>
Subject: Re: Optimised memset64/memset32 for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <willy@infradead.org>, Christophe LEROY
 <christophe.leroy@c-s.fr>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Mar 2017 08:26:12 +1100
In-Reply-To: <20170321132910.GA4482@bombadil.infradead.org>
References: <20170320211447.GB5073@bombadil.infradead.org>
 <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
 <20170321132910.GA4482@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-21 at 06:29 -0700, Matthew Wilcox wrote:
> 
> Well, those are the generic versions in the first patch:
> 
> http://git.infradead.org/users/willy/linux-dax.git/commitdiff/538b977
> 6ac925199969bd5af4e994da776d461e7
> 
> so if those are good enough for you guys, there's no need for you to
> do anything.
> 
> Thanks for your time!

I suspect on ppc64 we can do much better, if anything moving 64-bit at
a time. Matthew, what are the main use cases of these ?

Cheers,
Ben.

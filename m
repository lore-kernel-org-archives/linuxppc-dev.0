Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYwPM5DfwzDw2n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 10:56:07 +1100 (AEDT)
Date: Thu, 8 Dec 2016 10:56:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Sant
 <sachinp@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt  <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Nicholas  Piggin <npiggin@gmail.com>
Subject: Re: linux-next: Tree for Dec 7 (kallsyms failure)
Message-ID: <20161208105607.68810cae@canb.auug.org.au>
In-Reply-To: <13d83759-40d3-593b-b53f-f3e75fb05b7a@infradead.org>
References: <20161207172432.184970d7@canb.auug.org.au>
 <13d83759-40d3-593b-b53f-f3e75fb05b7a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Randy,

On Wed, 7 Dec 2016 15:42:32 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I started seeing this yesterday (2016-1206).
> This is on x86_64.
> 
> Anybody know about it?
> 
> kallsyms failure: relative symbol value 0xffffffff81000000 out of range in relative mode

I got a similar failure starting a few days ago on my powerpc
allyesconfig build.  I was assuming that it was PowerPC specific, but
noone has found a cause yet.

-- 
Cheers,
Stephen Rothwell

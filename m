Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wddbp1mXTzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 17:03:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for May 31
In-Reply-To: <20170601161315.6ec8e08e@canb.auug.org.au>
References: <20170531153227.7098f0a1@canb.auug.org.au>
 <8737bk44w8.fsf@concordia.ellerman.id.au>
 <20170601161315.6ec8e08e@canb.auug.org.au>
Date: Thu, 01 Jun 2017 17:03:33 +1000
Message-ID: <87wp8w2nqy.fsf@concordia.ellerman.id.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Michael,
>
> On Thu, 01 Jun 2017 16:07:51 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>> 
>> > Changes since 20170530:
>> >
>> > Non-merge commits (relative to Linus' tree): 3325
>> >  3598 files changed, 135000 insertions(+), 72065 deletions(-)  
>> 
>> More or less all my powerpc boxes failed to boot this.
>
> Good timing :-)  How about the linux-next I just released.  It has had
> a few of the mm changes removed since yesterday.

Yep, the offending patch seems to have been dropped.

cheers

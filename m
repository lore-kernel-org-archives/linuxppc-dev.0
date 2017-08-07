Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0195.hostedemail.com
 [216.40.44.195])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR1JW6YhtzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 01:13:47 +1000 (AEST)
Message-ID: <1502118820.2219.19.camel@perches.com>
Subject: Re: [PATCH] block/ps3vram: Delete an error message for a failed
 memory allocation in ps3vram_cache_init()
From: Joe Perches <joe@perches.com>
To: Geoff Levand <geoff@infradead.org>, SF Markus Elfring
 <elfring@users.sourceforge.net>, linuxppc-dev@lists.ozlabs.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Mon, 07 Aug 2017 08:13:40 -0700
In-Reply-To: <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
 <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-07 at 08:10 -0700, Geoff Levand wrote:
> On 08/07/2017 03:52 AM, SF Markus Elfring wrote:
> > Omit an extra message for a memory allocation failure in this function.
> NACK
> 
> When a user asks me for help I would certainly like to get 
> 'Could not allocate cache tags' as apposed to nothing, since
> the return value of ps3vram_cache_init() is not checked.

You still get a dump_stack on alloc failure.

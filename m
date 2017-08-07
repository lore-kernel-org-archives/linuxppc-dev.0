Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR1FQ3pvqzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 01:11:06 +1000 (AEST)
Subject: Re: [PATCH] block/ps3vram: Delete an error message for a failed
 memory allocation in ps3vram_cache_init()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
Date: Mon, 7 Aug 2017 08:10:59 -0700
MIME-Version: 1.0
In-Reply-To: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2017 03:52 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 7 Aug 2017 12:37:01 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.

NACK

When a user asks me for help I would certainly like to get 
'Could not allocate cache tags' as apposed to nothing, since
the return value of ps3vram_cache_init() is not checked.

If you want to make an improvement please add a check for
success of ps3vram_cache_init() in ps3vram_probe().

-Geoff

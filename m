Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR2xz5SybzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 02:27:51 +1000 (AEST)
Subject: Re: block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
To: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
 <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <dd16f28c-1613-cfb2-5349-07aaac2f2f5a@users.sourceforge.net>
Date: Mon, 7 Aug 2017 18:27:04 +0200
MIME-Version: 1.0
In-Reply-To: <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Omit an extra message for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
> 
> NACK
> 
> When a user asks me for help I would certainly like to get 
> 'Could not allocate cache tags' as apposed to nothing,

Do you find the default allocation failure report insufficient?


> since the return value of ps3vram_cache_init() is not checked.

Are there any more update candidates to consider for better exception handling?

Regards,
Markus

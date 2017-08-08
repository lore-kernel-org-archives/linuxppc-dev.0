Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRSTp2p3DzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 18:38:21 +1000 (AEST)
Subject: Re: block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
To: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
 <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
 <dd16f28c-1613-cfb2-5349-07aaac2f2f5a@users.sourceforge.net>
 <8d140d00-935c-da0a-ff2e-167abe642bda@infradead.org>
 <32cdcd8a-1000-223c-71da-4c9119954d4e@users.sourceforge.net>
 <3a657b44-2bc8-ee05-3a42-db7af354967e@infradead.org>
 <57b472a0-0245-f821-cea8-171c34cc9df7@users.sourceforge.net>
 <db00e381-a79e-4db2-2263-458b80e4844c@infradead.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a4b69182-80d3-c5e6-ab7a-6da2b99e5ddc@users.sourceforge.net>
Date: Tue, 8 Aug 2017 10:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <db00e381-a79e-4db2-2263-458b80e4844c@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> https://patchwork.ozlabs.org/patch/798575/
> 
> I submitted your patch

Thanks for your constructive feedback.
https://patchwork.ozlabs.org/patch/798850/


> and a fix to ps3vram_probe() with the other patches in my queue.

I find it nice that you picked this change opportunity up after
a bit of discussion (before an other developer would eventually
have tackled it also).

“Check return of ps3vram_cache_init”
https://patchwork.ozlabs.org/patch/798853/

1. Unfortunately, I find that this specific update suggestion does not fit
   to the Linux coding style convention.

   “…
   Do not unnecessarily use braces where a single statement will do.
   …”

2. How do you think about to use the check “if (error)” instead?

3. Will an additional commit description be useful?

Regards,
Markus

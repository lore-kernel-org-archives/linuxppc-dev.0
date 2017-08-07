Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR6Rm4MyZzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 05:05:24 +1000 (AEST)
Subject: Re: block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
To: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
 <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
 <dd16f28c-1613-cfb2-5349-07aaac2f2f5a@users.sourceforge.net>
 <8d140d00-935c-da0a-ff2e-167abe642bda@infradead.org>
 <32cdcd8a-1000-223c-71da-4c9119954d4e@users.sourceforge.net>
 <3a657b44-2bc8-ee05-3a42-db7af354967e@infradead.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <57b472a0-0245-f821-cea8-171c34cc9df7@users.sourceforge.net>
Date: Mon, 7 Aug 2017 21:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <3a657b44-2bc8-ee05-3a42-db7af354967e@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> I didn't consider one would be triggered by the kzalloc failure.
>>
>> Do you reconsider any special system settings for further
>> software evolution then?
> 
> Sorry, I don't quite understand your question.

Do you try to configure the Linux error reporting to any special needs?


> I think your original patch is OK,

How does this feedback fit to the initial response “Not Applicable”?
https://patchwork.ozlabs.org/patch/798575/


> and I would appreciate if you added a check for failure of ps3vram_cache_init()
> in ps3vram_probe().

I unsure if this adjustment will need more software updates.


> If you decide not to add that check I'll create a patch for it later.

I am curious on who will pick this update candidate up as the next improvement.
Have you got any preferences for the exception handling there?

Regards,
Markus

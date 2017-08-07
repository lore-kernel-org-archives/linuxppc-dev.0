Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR83d2ysSzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 06:18:05 +1000 (AEST)
Subject: Re: block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
 <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
 <dd16f28c-1613-cfb2-5349-07aaac2f2f5a@users.sourceforge.net>
 <8d140d00-935c-da0a-ff2e-167abe642bda@infradead.org>
 <32cdcd8a-1000-223c-71da-4c9119954d4e@users.sourceforge.net>
 <3a657b44-2bc8-ee05-3a42-db7af354967e@infradead.org>
 <57b472a0-0245-f821-cea8-171c34cc9df7@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <db00e381-a79e-4db2-2263-458b80e4844c@infradead.org>
Date: Mon, 7 Aug 2017 13:17:36 -0700
MIME-Version: 1.0
In-Reply-To: <57b472a0-0245-f821-cea8-171c34cc9df7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2017 12:04 PM, SF Markus Elfring wrote:
>> I think your original patch is OK,
> 
> How does this feedback fit to the initial response “Not Applicable”?
> https://patchwork.ozlabs.org/patch/798575/

I submitted your patch and a fix to ps3vram_probe() with
the other patches in my queue.  Thanks for your contribution.

-Geoff

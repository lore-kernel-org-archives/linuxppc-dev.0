Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com
 [IPv6:2607:f8b0:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LhXk0Jb2zF0Pc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 21:25:09 +1000 (AEST)
Received: by mail-vk0-x236.google.com with SMTP id x204so834006vkd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 04:25:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d0z6knoy.fsf@concordia.ellerman.id.au>
References: <20180406052424.29841-1-bsingharora@gmail.com>
 <20180406052424.29841-2-bsingharora@gmail.com>
 <87d0z6knoy.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 11 Apr 2018 21:25:06 +1000
Message-ID: <CAKTCnzmGCRqqM=uvRgaRT2EfyHUqQcwUMRS2uWbzDD3+BtWA-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mm/memtrace: Let the arch hotunplug code
 flush cache
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Rashmica Gupta <rashmica.g@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2018 at 9:05 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> Don't do this via custom code, instead now that we have support
>> in the arch hotplug/hotunplug code, rely on those routines
>> to do the right thing.
>>
>> Fixes: 9d5171a8f248 ("powerpc/powernv: Enable removal of memory for in memory tracing")
>
> That's not really right.
>
> This patch doesn't fix it, the previous patch did.
>
> If I just backport this patch then it's still broken.
>
> So I'll tag patch 1 with the above Fixes: tag and add stable, and then
> this just becomes a cleanup.
>

Fair point, the previous one does indeed fix things. I can do a minimal backport
fixing .size to .line_size if needed.

Cheers,
Balbir

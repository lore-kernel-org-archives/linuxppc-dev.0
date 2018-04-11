Return-Path: <rashmica.g@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LVhY04B2zDsFQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 14:01:16 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id u86so309972pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 21:01:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] powerpc/mm/memtrace: Let the arch hotunplug code
 flush cache
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, rashmica.g@gmail.com, benh@kernel.crashing.org
References: <20180406052424.29841-1-bsingharora@gmail.com>
 <20180406052424.29841-2-bsingharora@gmail.com>
From: rashmica <rashmica.g@gmail.com>
Message-ID: <7768aa87-2729-99a1-73f9-6ecc37f1aeb2@gmail.com>
Date: Wed, 11 Apr 2018 14:01:11 +1000
MIME-Version: 1.0
In-Reply-To: <20180406052424.29841-2-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/04/18 15:24, Balbir Singh wrote:
> Don't do this via custom code, instead now that we have support
> in the arch hotplug/hotunplug code, rely on those routines
> to do the right thing.
>
> Fixes: 9d5171a8f248 ("powerpc/powernv: Enable removal of memory for in memory tracing")
> because the older code uses ppc64_caches.l1d.size instead of
> ppc64_caches.l1d.line_size
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>

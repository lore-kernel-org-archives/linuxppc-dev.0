Return-Path: <bobby.prani@gmail.com>
Received: from mail-lb0-x22a.google.com (mail-lb0-x22a.google.com
 [IPv6:2a00:1450:4010:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7290E1A1631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:12:43 +1000 (EST)
Received: by mail-lb0-f170.google.com with SMTP id l4so6839764lbv.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 06:12:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWz+4ctGr92fJmi0GB1QrxRMy3GKC_KDpZfK-sriYP-FQ@mail.gmail.com>
References: <1408482065-18457-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdWz+4ctGr92fJmi0GB1QrxRMy3GKC_KDpZfK-sriYP-FQ@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 20 Aug 2014 09:12:08 -0400
Message-ID: <CAJhHMCCkCSKEB1uUXEwj=NjMoK30q+3xBkbEP9Lwy=hXuCpbcw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix build failure when MEMORY_HOTPLUG=y
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Cc: open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Andew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2014 at 4:00 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> 1.9.1
>
> In light of my investigation for your spufs patch, I guess this is a non-SMP
> PSERIES config?

So what happens is SELECT_MEMORY_MODEL choses FLATMEM_MANUAL because
of which SPARSEMEM is not enabled despite having
ARCH_SPARSEMEM_ENABLE=y.

-- 
Pranith

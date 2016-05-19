Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9QXd1r9CzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 19:20:49 +1000 (AEST)
Received: by mail-wm0-f54.google.com with SMTP id r12so70795956wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 02:20:49 -0700 (PDT)
Date: Thu, 19 May 2016 11:20:44 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel-build-reports@lists.linaro.org,
 Olof's autobuilder <build@lixom.net>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Dave Chinner <david@fromorbit.com>,
 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: next build: 37 warnings 2 failures (next/next-20160519)
Message-ID: <20160519092044.GI26110@dhcp22.suse.cz>
References: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
 <3211556.r7N0gQRgk6@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3211556.r7N0gQRgk6@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 19-05-16 11:07:09, Arnd Bergmann wrote:
[...]
> >       6 mm/page_alloc.c:3651:6: warning: 'compact_result' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> I'm surprised this one is still there, I sent a patch but Michal Hocko came up with
> a better fix on May 12, which was not applied yet.
> 
> Michael, can you resend this one to Andrew? I suspect he missed it as it was
> sent as a reply to mine.

Andrew has taken the patch IIRC but he hasn't released any mmotm since
then so it didn't get to the linux-next.
-- 
Michal Hocko
SUSE Labs

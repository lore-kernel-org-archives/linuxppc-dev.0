Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9WkY3QfzzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 23:14:44 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michal Hocko <mhocko@kernel.org>
Cc: kernel-build-reports@lists.linaro.org, Olof's autobuilder <build@lixom.net>,
 olof@lixom.net, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ross Lagerwall <ross.lagerwall@citrix.com>, Dave Chinner <david@fromorbit.com>,
 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: next build: 37 warnings 2 failures (next/next-20160519)
Date: Thu, 19 May 2016 15:14:20 +0200
Message-ID: <2590345.NrfsVLDrUS@wuerfel>
In-Reply-To: <20160519092044.GI26110@dhcp22.suse.cz>
References: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
 <3211556.r7N0gQRgk6@wuerfel> <20160519092044.GI26110@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 May 2016 11:20:44 Michal Hocko wrote:
> On Thu 19-05-16 11:07:09, Arnd Bergmann wrote:
> [...]
> > >       6 mm/page_alloc.c:3651:6: warning: 'compact_result' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > I'm surprised this one is still there, I sent a patch but Michal Hocko came up with
> > a better fix on May 12, which was not applied yet.
> > 
> > Michael, can you resend this one to Andrew? I suspect he missed it as it was
> > sent as a reply to mine.
> 
> Andrew has taken the patch IIRC but he hasn't released any mmotm since
> then so it didn't get to the linux-next.
> 

Ok, cool, that explains it.

	Arnd

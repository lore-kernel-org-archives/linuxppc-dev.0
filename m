Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9WlZ5P3bzDqKw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 23:15:38 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
 kernel-build-reports@lists.linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Linus Walleij <linus.ml.walleij@gmail.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, olof@lixom.net,
 Andrew Morton <akpm@linux-foundation.org>,
 Olof's autobuilder <build@lixom.net>
Subject: Re: next build: 37 warnings 2 failures (next/next-20160519)
Date: Thu, 19 May 2016 15:15:09 +0200
Message-ID: <3230968.fKGkPFmYnk@wuerfel>
In-Reply-To: <573D886E.1050205@ti.com>
References: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
 <3211556.r7N0gQRgk6@wuerfel> <573D886E.1050205@ti.com>
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

On Thursday 19 May 2016 15:03:34 Kishon Vijay Abraham I wrote:
> > 
> >>       1 drivers/phy/phy-exynos-mipi-video.c:238:13: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > I sent a patch on May 11, it was reviewed by Krzysztof Kozlowski, but not yet
> > applied.
> 
> Is it okay if I send this during the -rc cycle?
> 

Yes, it's a bug fix, so it should just go in as soon as possible, that's what
the -rc cycle is for after all.

	Arnd

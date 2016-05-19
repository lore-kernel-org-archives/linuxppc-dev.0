Return-Path: <sstabellini@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Rxl2srtzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 20:24:09 +1000 (AEST)
Date: Thu, 19 May 2016 11:24:00 +0100 (BST)
From: Stefano Stabellini <sstabellini@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: kernel-build-reports@lists.linaro.org,
 Olof's autobuilder <build@lixom.net>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Dave Chinner <david@fromorbit.com>,
 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, david.vrabel@citrix.com,
 boris.ostrovsky@oracle.com, sstabellini@kernel.org
Subject: Re: next build: 37 warnings 2 failures (next/next-20160519)
In-Reply-To: <3211556.r7N0gQRgk6@wuerfel>
Message-ID: <alpine.DEB.2.10.1605191122450.2914@sstabellini-ThinkPad-X260>
References: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
 <3211556.r7N0gQRgk6@wuerfel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 May 2016, Arnd Bergmann wrote:
> >       2 drivers/xen/balloon.c:154:13: warning: 'release_memory_resource' declared 'static' but never defined [-Wunused-function]
> 
> I sent a patch on May 11, subject "xen: remove incorrect forward declaration" and
> Stefano Stabellini reviewed it. Ross Lagerwall did the same patch a day earlier,
> but neither of them has made it into linux-next so far. According to Ross, this
> one should be backported to v4.4.

It's on our radar, the patch hasn't been lost.

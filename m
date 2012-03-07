Return-Path: <linus.walleij@linaro.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 568C3B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 19:33:51 +1100 (EST)
Received: by iakh37 with SMTP id h37so8879628iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2012 00:33:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Date: Wed, 7 Mar 2012 09:33:49 +0100
Message-ID: <CACRpkdYry6G4gi7LdVM4gYOQBKZCoQxdzLAGg1WcjB6rVD-PPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
From: Linus Walleij <linus.walleij@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Barry Song <baohua.song@csr.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 6, 2012 at 11:33 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:

I just applied the latest patches right off and tested with some stressy
MMC operations on the U300 and Ux500. (I had some minor hell
since patch 8/9 and 9/9 were uuencoded but managed to fix it...)

It works like a charm!

The patches look good too.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

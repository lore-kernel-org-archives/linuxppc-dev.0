Return-Path: <shawn.guo@linaro.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 126CEB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 19:59:58 +1100 (EST)
Received: by iakh37 with SMTP id h37so2247168iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2012 00:59:54 -0800 (PST)
Date: Fri, 9 Mar 2012 16:59:46 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
Message-ID: <20120309085943.GO2499@S2101-09.ap.freescale.net>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Vinod Koul <vinod.koul@intel.com>, Barry Song <baohua.song@csr.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2012 at 10:33:21PM +0000, Russell King - ARM Linux wrote:
...
>  drivers/dma/imx-sdma.c                   |   23 ++------
...
>  drivers/dma/mxs-dma.c                    |   23 ++------

Tested-by: Shawn Guo <shawn.guo@linaro.org>

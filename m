Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 18627B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 20:07:25 +1100 (EST)
Date: Wed, 7 Mar 2012 09:06:40 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
Message-ID: <20120307090640.GK17370@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <CACRpkdYry6G4gi7LdVM4gYOQBKZCoQxdzLAGg1WcjB6rVD-PPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdYry6G4gi7LdVM4gYOQBKZCoQxdzLAGg1WcjB6rVD-PPQ@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
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

On Wed, Mar 07, 2012 at 09:33:49AM +0100, Linus Walleij wrote:
> On Tue, Mar 6, 2012 at 11:33 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > This patch series cleans up the handling of cookies in DMA engine drivers.
> > This is done by providing a set of inline library functions for common
> > tasks:
> 
> I just applied the latest patches right off and tested with some stressy
> MMC operations on the U300 and Ux500. (I had some minor hell
> since patch 8/9 and 9/9 were uuencoded but managed to fix it...)

That'll be some MTA deciding to change the encoding, probably because some
MTA spotted UTF-8 characters in the description and decided to convert to
base64.

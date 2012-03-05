Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0D12B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 08:02:25 +1100 (EST)
Date: Mon, 5 Mar 2012 20:58:41 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/9] DMA engine cookie handling cleanups
Message-ID: <20120305205841.GB17791@n2100.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 Barry Song <baohua.song@csr.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2012 at 09:50:51PM +0100, Linus Walleij wrote:
> On Mon, Mar 5, 2012 at 9:14 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > This patch series cleans up the handling of cookies in DMA engine drivers.
> > This is done by providing a set of inline library functions for common
> > tasks:
> 
> Overall this looks good, but I have a problem:
> patch [1/9] does not appear in any subscribed accounts (it may be on
> my @stericsson.com address, will check tomorrow)

Patch 1 is just a couple of line changes to mv_xor.[ch]

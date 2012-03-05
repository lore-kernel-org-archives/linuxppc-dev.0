Return-Path: <hartleys@visionengravers.com>
Received: from mail127.messagelabs.com (mail127.messagelabs.com
 [216.82.250.115])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail127.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C2CAB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 10:46:57 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux
 <linux@arm.linux.org.uk>
Date: Mon, 5 Mar 2012 17:44:09 -0600
Subject: RE: [PATCH 0/9] DMA engine cookie handling cleanups
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF555B5@AUSP01VMBX24.collaborationhost.net>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
In-Reply-To: <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 Barry Song <baohua.song@csr.com>, Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, March 05, 2012 1:51 PM, Linus Walleij wrote:
> On Mon, Mar 5, 2012 at 9:14 PM, Russell King - ARM Linux wrote:
>
>> This patch series cleans up the handling of cookies in DMA engine driver=
s.
>> This is done by providing a set of inline library functions for common
>> tasks:
>
> Overall this looks good, but I have a problem:
> patch [1/9] does not appear in any subscribed accounts (it may be on
> my @stericsson.com address, will check tomorrow)

Patch 8/9 also doesn't appear to be on the mailing list.

> One I get hold of an ungmangled copy I can test the series on
> ux500 and U300.
>
> Is it just stuck in moderation because of size or something like that?

I'm also trying to test the series on ep93xx but have some compile issues
with patches [3/9] and [6/9].

Regards,
Hartley

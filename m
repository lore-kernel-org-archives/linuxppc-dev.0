Return-Path: <linus.walleij@linaro.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA485B70DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 07:50:54 +1100 (EST)
Received: by iakh37 with SMTP id h37so6430411iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2012 12:50:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120305201411.GA17791@n2100.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
Date: Mon, 5 Mar 2012 21:50:51 +0100
Message-ID: <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
Subject: Re: [PATCH 0/9] DMA engine cookie handling cleanups
From: Linus Walleij <linus.walleij@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
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

On Mon, Mar 5, 2012 at 9:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:

Overall this looks good, but I have a problem:
patch [1/9] does not appear in any subscribed accounts (it may be on
my @stericsson.com address, will check tomorrow)

One I get hold of an ungmangled copy I can test the series on
ux500 and U300.

Is it just stuck in moderation because of size or something like that?

Yours,
Linus Walleij

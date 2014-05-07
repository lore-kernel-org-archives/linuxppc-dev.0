Return-Path: <tim.kryger@linaro.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 979521401AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 06:49:09 +1000 (EST)
Received: by mail-oa0-f51.google.com with SMTP id n16so1943085oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 May 2014 13:49:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86mwf5tn0v.fsf@void.printf.net>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <535E84FB.4080305@wwwdotorg.org> <86mwf5tn0v.fsf@void.printf.net>
Date: Wed, 7 May 2014 13:49:06 -0700
Message-ID: <CAAYSxhr15dMLT8kuBd6gaFX+WrRgAqxKoWPBgkfVhzHMx299=A@mail.gmail.com>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
From: Tim Kryger <tim.kryger@linaro.org>
To: Chris Ball <chris@printf.net>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linux Doc List <linux-doc@vger.kernel.org>,
 Seungwon Jeon <tgih.jun@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Device Tree List <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, spear-devel@list.st.com,
 Rob Herring <robh+dt@kernel.org>, Ben Dooks <ben-linux@fluff.org>,
 linux-tegra@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Shawn Guo <shawn.guo@freescale.com>, Barry Song <baohua@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2014 at 9:52 AM, Chris Ball <chris@printf.net> wrote:
> Hi,
>
> On Mon, Apr 28 2014, Stephen Warren wrote:
>> The series,
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>>
>> (On an NVIDIA Tegra "Jetson TK1" board, with the patches applied on top
>> of next-20140428, also with Andrew Bresticker's Tegra SDHCI patches
>> "mmc: tegra: disable UHS modes" and "mmc: tegra: fix reporting of base
>> clock frequency" applied)
>
> Thanks very much Stephen, Russell for the series, and Ulf.
>
> This seems like a good time to merge to mmc-next and call for testing
> in linux-next -- I'm happy to merge a v2 PR when ready.
>
> - Chris.

Hi Russell,

Do you have a rough idea about when you will post your v2 pull request?

I have a pending sdhci patch that I would like to rebase on top of
your latest work once it is available.

Thanks,
Tim Kryger

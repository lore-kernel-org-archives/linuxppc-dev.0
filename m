Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qg0-f41.google.com (mail-qg0-f41.google.com
 [209.85.192.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D9451400F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 20:52:15 +1000 (EST)
Received: by mail-qg0-f41.google.com with SMTP id j107so1622251qga.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 03:52:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140424101726.GH26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
 <20140424101726.GH26756@n2100.arm.linux.org.uk>
Date: Thu, 24 Apr 2014 12:52:11 +0200
Message-ID: <CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Chris Ball <chris@printf.net>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Michal Simek <michal.simek@xilinx.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>,
 spear-devel@list.st.com, Rob Herring <robh+dt@kernel.org>,
 Ben Dooks <ben-linux@fluff.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Shawn Guo <shawn.guo@freescale.com>, Barry Song <baohua@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>,
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

On 24 April 2014 12:17, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Apr 24, 2014 at 10:25:42AM +0200, Ulf Hansson wrote:
>> I have looked though the patches up until patch 33 and this is clearly
>> a nice piece of clean-up /fixes work for sdhci. Besides my minor
>> comments per patch, I don't have any objections code-review wise to
>> proceed merging them.
>>
>> I have also tried to applied them on Chris' mmc-next branch,
>> unfortunate it fails at patch 23, so it would be nice to get a
>> re-based patchset for the mmc-next branch.
>
> I /could/ rebase it but then I wouldn't be able to produce the patch
> sets/patches for others [*] (such as the Novena project) to derive
> their kernel tree from my iMX6 patch set.
>
> What I'd prefer is to keep the patch set intact, and provide Chris
> with a pull request for it up to patch 33, which would need a
> conflict fixed - and this would mean that I can be sure that what
> I'm testing, and what I'm distributing is what Chris will also be
> submitting.

Whether there are more than one conflict, I don't know. I just stopped
at patch 23.

Moreover, there are other patches for sdhci that have been posted and
being discussed. In principle, we then need to put all these on hold
to prevent further conflicts. I guess that doable, as long as we don't
to that for too long. Maybe Chris have some more thoughts how to
handle this!?

Kind regards
Ulf Hansson

>
> * - this currently stands at 230 patches in all - mmc + l2c + fec +
>     imx-drm + other iMX6 changes.
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

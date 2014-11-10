Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C44541A0185
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 15:56:35 +1100 (AEDT)
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4469E14011B
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 15:56:34 +1100 (AEDT)
Received: by mail-oi0-f47.google.com with SMTP id a3so4878138oib.20
 for <linuxppc-dev@ozlabs.org>; Sun, 09 Nov 2014 20:56:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c94b68be09dd4bfaa8a80d9877362fb5@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
 <CAKohpokotKSvQ13uU4MnCer+qzBUUbGVTd19y7xswCAEKk3nGQ@mail.gmail.com>
 <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
 <CAKohpokSuKOwZ3-OWFtU0z7E1fsMg4tyPiUoFUfw26pD9Py=MA@mail.gmail.com>
 <c94b68be09dd4bfaa8a80d9877362fb5@DM2PR03MB574.namprd03.prod.outlook.com>
Date: Mon, 10 Nov 2014 10:26:32 +0530
Message-ID: <CAKohpokOorF82EDwTyvCcEhpQJvMOXfLzotxj+E9Ys6Jydbk5g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27 October 2014 09:09, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> Do we have a conclusion yet?

No. You can keep your initial duplication of Kconfig entries for the time being.

Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmYPT57bfzF0qN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 21:19:25 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id m5so476490pff.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 02:19:25 -0800 (PST)
Date: Wed, 21 Feb 2018 15:49:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Message-ID: <20180221101920.GQ28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
 <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7>
 <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
 <20180221100209.GP28462@vireshk-i7>
 <CAJZ5v0hCQCo3EwprC7RP5Jsn8_tMp-1fbMcPwKgujiQ8YeH0aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hCQCo3EwprC7RP5Jsn8_tMp-1fbMcPwKgujiQ8YeH0aA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21-02-18, 11:17, Rafael J. Wysocki wrote:
> The driver is expected to call cpufreq_table_validate_and_show() at
> ->init() time and fail ->init() if that fails.
> 
> That's kind of fragile, because it depends on the driver to do the right thing.

That's exactly what I am trying to explore here, i.e. Call
validate/show from core instead of drivers.

-- 
viresh

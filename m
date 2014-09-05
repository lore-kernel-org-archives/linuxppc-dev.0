Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFE231A1934
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 17:41:25 +1000 (EST)
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BFF914009C
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2014 17:41:24 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id i7so8218740oag.0
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Sep 2014 00:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
References: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
Date: Fri, 5 Sep 2014 13:11:22 +0530
Message-ID: <CAKohpo=chEW_TtXWCHa3OEwrqU25TPBES4icjMVxL6nezrf8+w@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] cpufreq/powernv: Set core pstate to a minimum just
 before hotplugging it out
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Dirk Brandewie <dirk.j.brandewie@intel.com>,
 Shreyas Prabhu <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Patrick Marlier <patrick.marlier@gmail.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5 September 2014 13:09, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> Today cpus go to winkle when they are offlined. Since it is the deepest
> idle state that we have, it is expected to save good amount of power as compared
> to online state, where cores can enter nap/fastsleep only which are
> shallower idle states.
> However we observed no powersavings with winkle as compared to nap/fastsleep
> and traced the problem to the pstate of the core being kept at a high even
> when the core is offline. This can keep the socket pstate high, thus burning
> power unnecessarily. This patchset fixes this issue.
>
> Changes in V2: Changed smp_call_function_any() to smp_call_function_single() in Patch[2/2]

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

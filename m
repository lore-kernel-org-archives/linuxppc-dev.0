Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 391E42C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 20:45:49 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id n10so552054oag.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 03:45:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130724101832.GA26943@blackmetal.musicnaut.iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <1374611079-28091-2-git-send-email-aaro.koskinen@iki.fi>
 <CAKohpo=t0C63m_WuZA-dGiLDtBu8FbdM8tgJLNh_NSAALnf+fw@mail.gmail.com>
 <20130724101832.GA26943@blackmetal.musicnaut.iki.fi>
Date: Wed, 24 Jul 2013 16:15:46 +0530
Message-ID: <CAKohpony71fjY580Nk-35P9WmR-WaXVb7+2Xv9do1taByK+ELA@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: pmac64: re-estimate G5 cpufreq transition
 latency
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nick Piggin <npiggin@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24 July 2013 15:48, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Wed, Jul 24, 2013 at 11:04:50AM +0530, Viresh Kumar wrote:
>> On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > The patch also enables to use ondemand governor on the latter.
>>
>> How? I can't see anything obvious here. :(
>
> It replaces CPUFREQ_ETERNAL with a proper value on older PowerMacs.
> ondemand does not accept CPUFREQ_ETERNAL transition latency.

Ahh.. In case you are sending it again, just add this info in log as people
might miss it.

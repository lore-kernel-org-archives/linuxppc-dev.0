Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B10941A0173
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Sep 2014 15:27:23 +1000 (EST)
Received: by mail-ob0-f179.google.com with SMTP id uz6so3567687obc.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Aug 2014 22:27:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409548719.13507.13.camel@localhost.localdomain>
References: <1409234816-10802-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohpokbYkL=cYQ+9-59vPhBmbAWqhrEz7RBPj5-edDB25DPgw@mail.gmail.com>
 <1409548719.13507.13.camel@localhost.localdomain>
Date: Mon, 1 Sep 2014 10:57:21 +0530
Message-ID: <CAKohpo=VaXOcEqGmmVE4A7KtYrVEtmLpMeaRm99G5oxJyetD5Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: powernv: Set the cpus to nominal frequency
 during reboot/kexec
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpa Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1 September 2014 10:48, Shilpa Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:
> Hi Viresh,
> On Fri, 2014-08-29 at 05:33 +0530, Viresh Kumar wrote:
>> On 28 August 2014 19:36, Shilpasri G Bhat
>> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> >
>> > Changes v1->v2:
>> > Invoke .target() driver callback to set the cpus to nominal frequency
>> > in reboot notifier, instead of calling cpufreq_suspend() as suggested
>> > by Viresh Kumar.
>> > Modified the commit message.
>>
>> This changelog will get commited, is this what you want?

You skipped replying to this and commited the same mistake again..

>
> This patch ensures the cpus to kexec/reboot at nominal frequency.
> Nominal frequency is the highest cpu frequency on PowerPC at
> which the cores can run without getting throttled.
>
> If the host kernel had set the cpus to a low pstate and then it
> kexecs/reboots to a cpufreq disabled kernel it would cause the target
> kernel to perform poorly. It will also increase the boot up time of
> the target kernel. So set the cpus to high pstate, in this case to
> nominal frequency before rebooting to avoid such scenarios.
>
> The reboot notifier will set the cpus to nominal frequncy.
>
> Changes v1->v2:
> Invoke .target() driver callback to set the cpus to nominal frequency
> in reboot notifier, instead of calling cpufreq_suspend() as suggested
> by Viresh Kumar.
> Modified the commit message.

This would get commited in git changelogs and probably you don't want
this. So please place them after the three dash '-' symbols below..

> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---

HERE>>>>>>>>>>>

>  drivers/cpufreq/powernv-cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

I have already Acked this, so you could have added that yourself
on this resend.

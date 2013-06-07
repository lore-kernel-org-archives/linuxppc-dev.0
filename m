Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id 11F902C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 21:49:04 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 17/18] cpufreq: powerpc: move cpufreq driver to
 drivers/cpufreq
Date: Fri, 07 Jun 2013 13:58:05 +0200
Message-ID: <36081985.E8ct76IG4n@vostro.rjw.lan>
In-Reply-To: <CAKohpom=HvLwn7q9gicJXmHExoaDKKHcgQgT=1F0SKu3N3bXSg@mail.gmail.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <CAKohpokgTmb6d79ipR9pV2iOfLSzngrPbMV3hFcuP64kbNYSQA@mail.gmail.com>
 <CAKohpom=HvLwn7q9gicJXmHExoaDKKHcgQgT=1F0SKu3N3bXSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: deepthi@linux.vnet.ibm.com, Robin Randhawa <robin.randhawa@arm.com>,
 linux-pm@vger.kernel.org, patches@linaro.org, Liviu.Dudau@arm.com,
 linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Steve.Bannister@arm.com,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 Andrew Morton <akpm@linux-foundation.org>, arvind.chauhan@arm.com,
 linuxppc-dev@lists.ozlabs.org, linaro-kernel@lists.linaro.org,
 charles.garcia-tobin@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, June 07, 2013 10:48:21 AM Viresh Kumar wrote:
> On 31 May 2013 16:20, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 20 May 2013 10:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> On 13 May 2013 11:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>> On 22 April 2013 12:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>>> On 9 April 2013 14:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>>>> On 5 April 2013 12:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>>>>> On 4 April 2013 18:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>>>>>> This patch moves cpufreq driver of powerpc platform to drivers/cpufreq.
> >>>>>>>
> >>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>>>>> Cc: Paul Mackerras <paulus@samba.org>
> >>>>>>> Cc: Olof Johansson <olof@lixom.net>
> >>>>>>> Cc: linuxppc-dev@lists.ozlabs.org
> >>>>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>>>>>> ---
> >>>>>>> Compile Tested only.
> >>>>>>>
> >>>>>>>  arch/powerpc/platforms/Kconfig                     | 31 ----------------------
> >>>>>>>  arch/powerpc/platforms/pasemi/Makefile             |  1 -
> >>>>>>>  arch/powerpc/platforms/powermac/Makefile           |  2 --
> >>>>>>>  drivers/cpufreq/Kconfig.powerpc                    | 26 ++++++++++++++++++
> >>>>>>>  drivers/cpufreq/Makefile                           |  3 +++
> >>>>>>>  .../cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c  |  0
> >>>>>>>  .../cpufreq/pmac32-cpufreq.c                       |  0
> >>>>>>>  .../cpufreq/pmac64-cpufreq.c                       |  0
> >>>>>>>  8 files changed, 29 insertions(+), 34 deletions(-)
> >>>>>>>  rename arch/powerpc/platforms/pasemi/cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c (100%)
> >>>>>>>  rename arch/powerpc/platforms/powermac/cpufreq_32.c => drivers/cpufreq/pmac32-cpufreq.c (100%)
> >>>>>>>  rename arch/powerpc/platforms/powermac/cpufreq_64.c => drivers/cpufreq/pmac64-cpufreq.c (100%)
> >>>>>>
> >>>>>> Hi Deepthi,
> >>>>>>
> >>>>>> Can you help testing this please?
> >>>>>
> >>>>> Ping!!
> >>>>
> >>>> Ping!!
> >>>
> >>> Hi Benjamin,
> >>>
> >>> Hope you are back from your vacations. Can you give it a try now?
> >>
> >> Ping!!
> >
> > Ping!!
> 
> Hi Rafael,
> 
> Its been more than 2 months now that this patch was first posted.
> And the response from Maintainers isn't so great, irrespective of
> how many times I pinged them.
> 
> This is what I think:
> - It looked functionally correct to Benjamin but he wanted somebody
> to actually test it.
> - Arnd gave his Ack (So it looked functionally correct to him too)
> - We can probably push this into linux-next now and see if somebody
> complains of any breakage it has done. If not we can get it pushed for
> 3.11.

I agree, applied to bleeding-edge.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

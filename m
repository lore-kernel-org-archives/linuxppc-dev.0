Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id 8E7D32C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 22:30:00 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: powerpc: Add cpufreq driver for Freescale
 e500mc SoCs
Date: Wed, 05 Jun 2013 14:29:54 +0200
Message-ID: <10099695.ktOfnWBzPa@vostro.rjw.lan>
In-Reply-To: <CAKohpokM_THCQRPfrsNcuN_MUe75BCsoeZWkK9gv7+3nAL2SRQ@mail.gmail.com>
References: <1370424648-1082-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAKohpokM_THCQRPfrsNcuN_MUe75BCsoeZWkK9gv7+3nAL2SRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Yuantian.Tang@freescale.com, linuxppc-dev@lists.ozlabs.org,
 cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, June 05, 2013 04:06:29 PM Viresh Kumar wrote:
> On 5 June 2013 15:00,  <Yuantian.Tang@freescale.com> wrote:
> > From: Tang Yuantian <yuantian.tang@freescale.com>
> >
> > Add cpufreq driver for Freescale e500mc, e5500 and e6500 SoCs
> > which are capable of changing the CPU frequency dynamically
> >
> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > v5:
> >         - enhance the CPU hotplug case
> >         - mask the disallowed CPU frequencies
> >         - remove freqs.cpu = policy->cpu;
> >         - refine the code style
> > v4:
> >         - rebase on bleeding-edge branch of Rafael's linux-pm.git
> >         - #define pr_fmt() for better debug prints
> >         - use newest cpufreq_notify_transition()
> >         - support CPU hotplug
> >         - remove table[i].index as it is not used
> >         - remove cpus_per_cluster
> > v3:
> >         - change sizeof(struct name).. to sizeof(*p)
> >         - remove the struct cpufreq_data, use global variable instead
> >         - resolve setting policy->cpus incorrectly
> >         - add CPUFREQ_POSTCHANGE notifier when setting frequency error
> > v2:
> >         - add depends on OF and COMMON_CLK in Kconfig
> >         - use clk.h instead of clk-provider.h
> >         - change per_cpu variable from struct to pointer
> >
> >  drivers/cpufreq/Kconfig.powerpc       |  10 +
> >  drivers/cpufreq/Makefile              |   1 +
> >  drivers/cpufreq/ppc-corenet-cpufreq.c | 380 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 391 insertions(+)
> >  create mode 100644 drivers/cpufreq/ppc-corenet-cpufreq.c
> 
> I haven't gone for a very deep review this time and it looked okay.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, queued up for 3.11.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

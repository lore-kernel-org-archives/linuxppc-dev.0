Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D5162C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 18:35:03 +1000 (EST)
Received: by mail-oa0-f52.google.com with SMTP id k14so7246378oag.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2013 01:35:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpokGkZ9m0v1QaoXEv1m0mZqY70adWpXf3edQGmZnToRRcg@mail.gmail.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <027e8f1d4ac8de6351115f15a408431558510abb.1365079581.git.viresh.kumar@linaro.org>
 <CAKohpokGkZ9m0v1QaoXEv1m0mZqY70adWpXf3edQGmZnToRRcg@mail.gmail.com>
Date: Tue, 9 Apr 2013 14:05:00 +0530
Message-ID: <CAKohpokpiw3zS32oDL+T09ToOQxc28w=2R2up5T3h3c2Agc0wg@mail.gmail.com>
Subject: Re: [PATCH 17/18] cpufreq: powerpc: move cpufreq driver to
 drivers/cpufreq
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rjw@sisk.pl, deepthi@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: robin.randhawa@arm.com, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, patches@linaro.org,
 Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 Steve.Bannister@arm.com, Paul Mackerras <paulus@samba.org>,
 Olof Johansson <olof@lixom.net>, arvind.chauhan@arm.com,
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

On 5 April 2013 12:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 4 April 2013 18:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> This patch moves cpufreq driver of powerpc platform to drivers/cpufreq.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> Compile Tested only.
>>
>>  arch/powerpc/platforms/Kconfig                     | 31 ----------------------
>>  arch/powerpc/platforms/pasemi/Makefile             |  1 -
>>  arch/powerpc/platforms/powermac/Makefile           |  2 --
>>  drivers/cpufreq/Kconfig.powerpc                    | 26 ++++++++++++++++++
>>  drivers/cpufreq/Makefile                           |  3 +++
>>  .../cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c  |  0
>>  .../cpufreq/pmac32-cpufreq.c                       |  0
>>  .../cpufreq/pmac64-cpufreq.c                       |  0
>>  8 files changed, 29 insertions(+), 34 deletions(-)
>>  rename arch/powerpc/platforms/pasemi/cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c (100%)
>>  rename arch/powerpc/platforms/powermac/cpufreq_32.c => drivers/cpufreq/pmac32-cpufreq.c (100%)
>>  rename arch/powerpc/platforms/powermac/cpufreq_64.c => drivers/cpufreq/pmac64-cpufreq.c (100%)
>
> Hi Deepthi,
>
> Can you help testing this please?

Ping!!

Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f42.google.com (mail-oa0-f42.google.com
 [209.85.219.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D6632C015D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 20:30:05 +1100 (EST)
Received: by mail-oa0-f42.google.com with SMTP id i18so1298756oag.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2013 02:30:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
Date: Wed, 3 Apr 2013 15:00:02 +0530
Message-ID: <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25 March 2013 22:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> This patch moves cpufreq driver of powerpc platform to drivers/cpufreq.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
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
> Benjamin/Paul/Olof,
>
> Any comments on this?

Ping!!

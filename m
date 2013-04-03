Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 495BA2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 21:30:43 +1100 (EST)
Message-ID: <1364985034.16520.12.camel@pasglop>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 03 Apr 2013 12:30:34 +0200
In-Reply-To: <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
 <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-03 at 15:00 +0530, Viresh Kumar wrote:
> On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 25 March 2013 22:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> This patch moves cpufreq driver of powerpc platform to drivers/cpufreq.
> >>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: Paul Mackerras <paulus@samba.org>
> >> Cc: Olof Johansson <olof@lixom.net>
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>  arch/powerpc/platforms/Kconfig                     | 31 ----------------------
> >>  arch/powerpc/platforms/pasemi/Makefile             |  1 -
> >>  arch/powerpc/platforms/powermac/Makefile           |  2 --
> >>  drivers/cpufreq/Kconfig.powerpc                    | 26 ++++++++++++++++++
> >>  drivers/cpufreq/Makefile                           |  3 +++
> >>  .../cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c  |  0
> >>  .../cpufreq/pmac32-cpufreq.c                       |  0
> >>  .../cpufreq/pmac64-cpufreq.c                       |  0
> >>  8 files changed, 29 insertions(+), 34 deletions(-)
> >>  rename arch/powerpc/platforms/pasemi/cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c (100%)
> >>  rename arch/powerpc/platforms/powermac/cpufreq_32.c => drivers/cpufreq/pmac32-cpufreq.c (100%)
> >>  rename arch/powerpc/platforms/powermac/cpufreq_64.c => drivers/cpufreq/pmac64-cpufreq.c (100%)
> >
> > Benjamin/Paul/Olof,
> >
> > Any comments on this?
> 
> Ping!!

I'm on vacation until end of April. No objection to the patch but
somebody needs to test it.

Cheers,
Ben.

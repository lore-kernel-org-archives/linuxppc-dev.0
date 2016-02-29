Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 384B81A005D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 01:40:04 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Li Yang <leoli@freescale.com>, Scott Wood <oss@buserror.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Jia Hongtao <hongtao.jia@freescale.com>,
 Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Mon, 29 Feb 2016 15:39:37 +0100
Message-ID: <2383054.EjbA6kk0Xz@wuerfel>
In-Reply-To: <CAJZ5v0joCpaPNxPzW2xpJ5Vt4MYgWdCvXE0PZb90S46pFhJH8w@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <8056913.EWiGLtcdOV@wuerfel>
 <CAJZ5v0joCpaPNxPzW2xpJ5Vt4MYgWdCvXE0PZb90S46pFhJH8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 29 February 2016 15:33:37 Rafael J. Wysocki wrote:
> >
> > Note the check on !CPU_THERMAL rather than !THERMAL in my patch, that
> > part was correct. I think the line should be
> >
> >         depends on !CPU_THERMAL || THERMAL
> >
> > as some other drivers do. I must have copied the line
> > from ARM_MT8173_CPUFREQ, which is a 'bool' symbol, when
> > it should have been the same as ARM_BIG_LITTLE_CPUFREQ and
> > CPUFREQ_DT.
> 
> OK, so any chance to update the patch?
> 

I've committed the update locally now, and will follow up tomorrow
with a new patch, unless it causes another build-time regression.

I'll also send the respective update for the mediatek driver, making
that a tristate option.

	Arnd

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 57A512C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 01:48:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 18/18] cpufreq: powerpc/platforms/cell: move cpufreq
 driver to drivers/cpufreq
Date: Thu, 4 Apr 2013 14:48:10 +0000
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <201304041302.09995.arnd@arndb.de>
 <CAKohpok_ftPoME0tFRMWMM9A2mNSOpQSvbJut0=AzhCuB-Yjrg@mail.gmail.com>
In-Reply-To: <CAKohpok_ftPoME0tFRMWMM9A2mNSOpQSvbJut0=AzhCuB-Yjrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201304041448.11052.arnd@arndb.de>
Cc: robin.randhawa@arm.com, linux-pm@vger.kernel.org, patches@linaro.org,
 Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 rjw@sisk.pl, Steve.Bannister@arm.com, arvind.chauhan@arm.com,
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

On Thursday 04 April 2013, Viresh Kumar wrote:
> 
> On 4 April 2013 18:32, Arnd Bergmann <arnd@arndb.de> wrote:
> > Moving the files is good, but I don't see a reason to make the cbe_cpufreq.h
> > header globally visible in include/linux/. Isn't it just used by as the
> > interface between ppc_cbe_cpufreq_pmi.c  and ppc_cbe_cpufreq.c?
> 
> When i moved it initially i thought it is also used by
> arch/powerpc/platforms/cell/cpufreq_spudemand.c and hence moved it
> to include/linux and never realized i am wrong..
> 
> Here is the fixup (And attached complete patch: original+fixup for Rafael
> to apply):


Acked-by: Arnd Bergmann <arnd@arndb.de>

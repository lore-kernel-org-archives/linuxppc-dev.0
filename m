Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3r63np2pzCzDq7w
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 08:05:33 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate
 management
Date: Sat, 14 May 2016 00:08:53 +0200
Message-ID: <2343292.GUrEpiMUq0@vostro.rjw.lan>
In-Reply-To: <20160509153204.GA21661@vireshk-i7>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160509153204.GA21661@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, May 09, 2016 09:02:04 PM Viresh Kumar wrote:
> On 03-05-16, 20:49, Akshay Adiga wrote:
> > Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
> > is in Rafael's linux-next.
> > 
> > - Patch [1] fixes WARN_ON in powernv_target_index()
> > - Patch [2] Deleting any pending timer to saves an unnecessary irq call
> >  in powernv_target_index()
> > 
> > Akshay Adiga (2):
> >   cpufreq: powernv: Move smp_call_function_any() out of irq safe block
> >   cpufreq: powernv: del_timer_sync when global and local pstate are
> >     equal
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both [1-2/2] applied, thanks!

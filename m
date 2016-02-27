Return-Path: <rjw@rjwysocki.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 743F31A0B6F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 11:05:29 +1100 (AEDT)
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 9753F140180
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 11:05:27 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH v10 1/2] cpufreq: powernv: Fix bugs in
 powernv_cpufreq_{init/exit}
Date: Sat, 27 Feb 2016 01:00:23 +0100
Message-ID: <3063057.dJbqXY2tKb@vostro.rjw.lan>
In-Reply-To: <20160226104500.GH5823@vireshk-i7>
References: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160226104500.GH5823@vireshk-i7>
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

On Friday, February 26, 2016 04:15:00 PM Viresh Kumar wrote:
> On 26-02-16, 16:06, Shilpasri G Bhat wrote:
> > Unregister the notifiers if cpufreq_driver_register() fails in
> > powernv_cpufreq_init(). Re-arrange the unregistration and cleanup routines
> > in powernv_cpufreq_exit() to free all the resources after the driver
> > has unregistered.
> > 
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 4.6, thanks!

Rafael

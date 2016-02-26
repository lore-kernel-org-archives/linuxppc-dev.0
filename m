Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0F281A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 10:22:02 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Jia Hongtao <hongtao.jia@freescale.com>,
 Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Sat, 27 Feb 2016 00:16:35 +0100
Message-ID: <3593471.QAyZdAuTcW@wuerfel>
In-Reply-To: <CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <2396230.MApG9VTrxr@wuerfel>
 <CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
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

On Friday 26 February 2016 17:07:09 Li Yang wrote:
> 
> I don't have a perfect solution either.  But I think this is still
> better than making cpufreq not usable.  The cpufreq driver will print
> out an error message if thermal is not reachable.  Maybe this can
> relief the confusion a little bit?

With my patch, the configuration will just force the cpufreq
driver to be a loadable module as well if thermal is a module,
so the dependency can be resolved by loading the thermal module first.

I think that is really the best way around the problem, and it
matches what other platforms do for the same problem.

	Arnd

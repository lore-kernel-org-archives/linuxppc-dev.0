Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A26D714008A
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 23:56:34 +1100 (EST)
Message-ID: <1395924977.5569.109.camel@pasglop>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ego@linux.vnet.ibm.com
Date: Thu, 27 Mar 2014 23:56:17 +1100
In-Reply-To: <20140327112031.GC27777@in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
 <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
 <20140327112031.GC27777@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-27 at 16:50 +0530, Gautham R Shenoy wrote:
> 
> Well, in the scenarios that we're interested in, it is highly unlikely
> that CONFIG_PREMPT is set. Hence we'll default to
> raw_smp_processor_id() anyway. So, I think we can retain
> smp_processor_id(). 

We don't know that. Some people are interested in running preempt
on these things. If raw is ok to call here, please use it.

Cheers,
Ben.

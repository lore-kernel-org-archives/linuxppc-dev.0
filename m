Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f43.google.com (mail-oa0-f43.google.com
 [209.85.219.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0D211400AD
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 21:23:39 +1100 (EST)
Received: by mail-oa0-f43.google.com with SMTP id eb12so4121773oac.30
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 03:23:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5333FBA8.1040107@linux.vnet.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
 <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
 <5333FBA8.1040107@linux.vnet.ibm.com>
Date: Thu, 27 Mar 2014 15:53:36 +0530
Message-ID: <CAKohponoSP2s3BYNb04mZOxCegcQHua1Pz7=dWN2nGo70OJOjw@mail.gmail.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27 March 2014 15:51, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> smp_processor_id() maps to debug_smp_processor_id() only if
> CONFIG_DEBUG_PREEMPT is set. Otherwise, it is same as raw_smp_processor_id().
> So I think its best to keep it as it is.

That was the case in .configs and so suggested raw_* variant. Keep it
as you want to :)

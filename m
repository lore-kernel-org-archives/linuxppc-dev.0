Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0234814008C
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 22:29:27 +1100 (EST)
Received: by mail-ob0-f173.google.com with SMTP id gq1so4120791obb.32
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 04:29:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140327112031.GC27777@in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
 <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
 <20140327112031.GC27777@in.ibm.com>
Date: Thu, 27 Mar 2014 16:59:24 +0530
Message-ID: <CAKohpom7TekvQmAO6yPqSrPQ2yz10vOezKrWh=aA5vWCE=jS+A@mail.gmail.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PM list <linux-pm@vger.kernel.org>,
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

On 27 March 2014 16:50, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> (That said, in the future if we want to export additional
> information, say pertaining to the voltage, we will have to keep a
> separate array anyway :-) )

Lets handle that once it comes.

> However, as of now, I am wary about reusing a variable provided by
> the core, whose type is fixed (which is not the type I am interested
> in) and whose interpretation is ambiguous (since it is also being used
> as a BOOST indicator).

I understand that..

> When we have a .is_boost field, or a flags field in the cpufreq_table,

Probably we might keep it as is and take the patch which I already
sent. In that case as well your stuff will continue to work..

> and once the .driver_data field is completely opaque, I would be
> comfortable making use of .driver_data to store the pstate_ids. So
> I'll send out those patches once the fixes are present in the
> core. For now, let this code stay as it is. I think we should be ok
> with the additional overhead of 1kb as of now.

Chances are more that all my changes would make it before this
driver and then you would be required to update this driver
before submission.

Return-Path: <viresh.linux@gmail.com>
Received: from mail-vc0-x230.google.com (mail-vc0-x230.google.com
 [IPv6:2607:f8b0:400c:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C5D42C00B9
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 19:42:55 +1100 (EST)
Received: by mail-vc0-f176.google.com with SMTP id lc6so2204289vcb.7
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 01:42:53 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 14:12:53 +0530
Message-ID: <CAOh2x==Lzeatp=7BoxuSH4PfxXqWqpHJ_KcwWdXXsFAftxTMCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] powernv, cpufreq:Add per-core locking to serialize
 frequency transitions
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
>
> On POWER systems, the CPU frequency is controlled at a core-level and
> hence we need to serialize so that only one of the threads in the core
> switches the core's frequency at a time.

Probably you don't need this anymore.

https://lkml.org/lkml/2014/3/21/23

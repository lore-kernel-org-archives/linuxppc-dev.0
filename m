Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6739D14009B
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 16:25:16 +1100 (EST)
Received: by mail-ob0-f174.google.com with SMTP id wo20so5380333obc.19
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 22:25:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
Date: Fri, 28 Mar 2014 10:55:12 +0530
Message-ID: <CAKohpomuwkVVOgEbk4ARE+N6eo_tii9Msd1FbTgZfFK8Dvm9Uw@mail.gmail.com>
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

On 27 March 2014 15:00, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> As of now, I prefer this patch be based on code that is in the -next
> tree. I'll get rid of the per-core locking once the serialization
> patch of the core is accepted.

Okay, its pushed in -next now :)

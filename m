Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 18787140087
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 22:13:00 +1100 (EST)
Message-ID: <1395918767.5569.99.camel@pasglop>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ego@linux.vnet.ibm.com
Date: Thu, 27 Mar 2014 22:12:47 +1100
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
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

On Thu, 2014-03-27 at 15:00 +0530, Gautham R Shenoy wrote:
> > > --- a/arch/powerpc/configs/pseries_le_defconfig
> > > +++ b/arch/powerpc/configs/pseries_le_defconfig
> > > @@ -350,3 +350,4 @@ CONFIG_CRYPTO_LZO=m
> > >  # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > >  CONFIG_CRYPTO_DEV_NX=y
> > >  CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> > > +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> > 
> > don't know how Rafael want this, but probably this part could have
> gone
> > through ppc tree..
> > 
> 
> That would mean multiple patches :-)

We can always fix the defconfig later but I am also find if Rafael
carries that bit.

Cheers,
Ben.

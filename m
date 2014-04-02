Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8716D1400E5
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 15:23:48 +1100 (EST)
Message-ID: <1396412608.1394.15.camel@pasglop>
Subject: Re: [PATCH REPOST v5 1/3] powernv, cpufreq: Select CPUFreq related
 Kconfig options for powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Wed, 02 Apr 2014 15:23:28 +1100
In-Reply-To: <1506880.SKUfks4BOU@vostro.rjw.lan>
References: <CAKohpo=jvswNPmUPEbS79bSp9ZWC1e3DjaEUX=O4CWMXfufHrw@mail.gmail.com>
 <1396336408-20954-3-git-send-email-ego@linux.vnet.ibm.com>
 <1396345609.28055.7.camel@pasglop> <1506880.SKUfks4BOU@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 cpufreq@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-02 at 00:03 +0200, Rafael J. Wysocki wrote:
> > Rafael, are you going to take these or should I send them to Linus ?
> > 
> > (I'd rather you take them :-)
> 
> I can do that, but the timing is pretty bad.  How urgent are they?

To be honest pretty urgent. It's a new drop-in driver so it shouldn't
be a huge deal.

We have distros really waiting for this to hit upstream... But I'll
leave that decision to you :-)

Cheers,
Ben.

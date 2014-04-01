Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 8EEC3140081
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 08:47:22 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH REPOST v5 1/3] powernv,
 cpufreq: Select CPUFreq related Kconfig options for powernv
Date: Wed, 02 Apr 2014 00:03:07 +0200
Message-ID: <1506880.SKUfks4BOU@vostro.rjw.lan>
In-Reply-To: <1396345609.28055.7.camel@pasglop>
References: <CAKohpo=jvswNPmUPEbS79bSp9ZWC1e3DjaEUX=O4CWMXfufHrw@mail.gmail.com>
 <1396336408-20954-3-git-send-email-ego@linux.vnet.ibm.com>
 <1396345609.28055.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, April 01, 2014 08:46:49 PM Benjamin Herrenschmidt wrote:
> On Tue, 2014-04-01 at 12:43 +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Enable CPUFreq for PowerNV. Select "performance", "powersave",
> > "userspace" and "ondemand" governors. Choose "ondemand" to be the
> > default governor.
> 
> Rafael, are you going to take these or should I send them to Linus ?
> 
> (I'd rather you take them :-)

I can do that, but the timing is pretty bad.  How urgent are they?

Rafael

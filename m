Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 9F1121400DF
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 21:47:48 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH REPOST v5 1/3] powernv,
 cpufreq: Select CPUFreq related Kconfig options for powernv
Date: Wed, 02 Apr 2014 13:03:35 +0200
Message-ID: <1621325.cz1O3Ng49e@vostro.rjw.lan>
In-Reply-To: <1396412608.1394.15.camel@pasglop>
References: <CAKohpo=jvswNPmUPEbS79bSp9ZWC1e3DjaEUX=O4CWMXfufHrw@mail.gmail.com>
 <1506880.SKUfks4BOU@vostro.rjw.lan> <1396412608.1394.15.camel@pasglop>
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

On Wednesday, April 02, 2014 03:23:28 PM Benjamin Herrenschmidt wrote:
> On Wed, 2014-04-02 at 00:03 +0200, Rafael J. Wysocki wrote:
> > > Rafael, are you going to take these or should I send them to Linus ?
> > > 
> > > (I'd rather you take them :-)
> > 
> > I can do that, but the timing is pretty bad.  How urgent are they?
> 
> To be honest pretty urgent. It's a new drop-in driver so it shouldn't
> be a huge deal.
> 
> We have distros really waiting for this to hit upstream... But I'll
> leave that decision to you :-)

Well, I've already sent a second pull request for this merge window
and I'm not going to send the next one before it is merged.

So, I can push them next week realistically.

Rafael

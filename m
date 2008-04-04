Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57098DDFC8
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 01:46:56 +1100 (EST)
Date: Fri, 4 Apr 2008 16:46:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: cpu_clock confusion (was: printk time confusion?)
Message-ID: <20080404144641.GA15844@elte.hu>
References: <1207146186.3957.11.camel@johannes.berg>
	<1207219724.10388.319.camel@pasglop>
	<1207240450.3797.22.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207240450.3797.22.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arndb@de.ibm.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi,
> 
> > > Not sure whether the lockdep patches or something else is causing this
> > > as I haven't checked w/o the patches yet, but I seem to be having some
> > > confusion of printk timestamps:
> > 
> > Tried reverting the patches ?
> 
> That didn't help, so it's not the lockdep patches causing it. I'm still
> seeing printk timestamps like this:
> 
> [    2.764009 (3/3)]
> [    4.272241 (2/2)]
> [    4.272322 (2/2)]
> [    4.272375 (2/2)]
> [    2.948002 (3/3)]
> 
> As you can see, I added printk_cpu and smp_processor_id() to the 
> printk timestamp output and thus it is obvious that the different 
> times come from different CPUs.

the fixes are queued for v2.6.26. You can pick them up from 
sched-devel/latest as well:

  http://people.redhat.com/mingo/sched-devel.git/README

	Ingo

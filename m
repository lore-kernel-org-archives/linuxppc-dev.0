Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 8D578DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 09:46:54 +1000 (EST)
Date: Fri, 21 Sep 2007 09:46:53 +1000
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for powerpc
	machines.
Message-ID: <20070920234653.GW9814@bakeyournoodle.com>
References: <20070919064947.4B5A1399910@thor>
	<1190216594.11899.3.camel@imap.mvista.com>
	<18161.50240.599267.768383@cargo.ozlabs.ibm.com>
	<1190306110.14264.7.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1190306110.14264.7.camel@localhost>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Daniel Walker <dwalker@mvista.com>, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 09:35:10AM -0700, john stultz wrote:
 
> I think what Daniel is pointing out is that the clocksource read
> function isn't the place for the __USE_RTC() conditional. 
> 
> It would likely be better instead of the timebase clocksource managing
> multiple type of hardware (timebase and RTC), to have a separate simple
> RTC clocksource, and then conditionally register one or the other at
> init time.

I'll create a seperate clocksource for the RTC case and use that as
appropriate.  I'll resend the patch series after I've booted it :)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!

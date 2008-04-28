Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id CFFEDDDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 14:38:06 +1000 (EST)
Date: Mon, 28 Apr 2008 14:38:05 +1000
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: get_cycles()
Message-ID: <20080428043805.GY20457@bakeyournoodle.com>
References: <4812DFA3.6090106@hypersurf.com>
	<20080426.001102.65527296.davem@davemloft.net>
	<4813E74B.1020506@hypersurf.com>
	<20080426.202135.145326755.davem@davemloft.net>
	<48145709.9020809@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <48145709.9020809@hypersurf.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 27, 2008 at 03:35:54AM -0700, Kevin Diggs wrote:

> I'm working on a cpufreq driver for the 750GX so I don't think I have to 
> worry about being to platform specific.
> 
> Would a compile time configuration be a good idea (hrtimer or 
> get_cycles() assisted timing)?

Save yourself the pain, and use the hrtimers infrastructure.
 
> In the 2.4 code I just used a timer 2 ticks in the future to be certain 
> I did not go under the 100 us PLL lock delay. I was trying to see if I 
> could cut the latency down.
> 
> What about using OF? Isn't there a timebase property for the cpus?

Sure, If you really don't want to use the infrastructure that's there
feel free to duplicate portions of arch/powerpc/kernel/time.c and
kernel/time/* into your cpufreq driver.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!

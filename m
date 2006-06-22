Return-Path: <pavel@atrey.karlin.mff.cuni.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.31.123]) by ozlabs.org (Postfix) with ESMTP id 6E0E667A3A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 05:24:05 +1000 (EST)
Date: Thu, 22 Jun 2006 15:12:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] windfarm got signal
Message-ID: <20060622131216.GA2959@openzaurus.ucw.cz>
References: <1150847482.16662.13.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1150847482.16662.13.camel@johannes>
Cc: linux-pm <linux-pm@lists.osdl.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> after cpu hotplug I decided to write some fake suspend routines for
> ppc64 that always fail to see what all the drivers would say... The
> first thing I saw was during the phase where all threads are stopped,
> that windfarm got a signal!
> 
> Shortly after that, the fans were revved up fully but I guess that's
> expected if the wf control loop exits.
> 
> So now I'm trying to see *why* it got a signal there. Any ideas? Is that
> expected with pm and windfarm just does the wrong thing there by taking
> the signal as a reason to exit the control thread?
> 
> [code in question is windfarm_core.c:wf_thread_func]

See kernel/power/process.c

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

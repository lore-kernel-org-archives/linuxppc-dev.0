Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 64D95DDF0E
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 06:59:37 +1000 (EST)
Date: Fri, 7 Sep 2007 15:59:56 -0500
From: Olof Johansson <olof@lixom.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
Message-ID: <20070907205956.GA8077@lixom.net>
References: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
	<1189173891.28781.162.camel@johannes.berg>
	<20070907191616.GB6765@lixom.net>
	<1189193188.28781.193.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189193188.28781.193.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 09:26:28PM +0200, Johannes Berg wrote:
> On Fri, 2007-09-07 at 14:16 -0500, Olof Johansson wrote:
> > On Fri, Sep 07, 2007 at 04:04:51PM +0200, Johannes Berg wrote:
> > > On Fri, 2007-09-07 at 00:44 +1000, Paul Mackerras wrote:
> > > > This creates a clockevent for the PowerPC decrementer and registers it
> > > > with the generic clock/timer system, and implements the dynamic ticks
> > > > (no idle HZ) option for PowerPC.
> > > 
> > > I tried both patches applied and with/without CONFIG_NOHZ but my quad G5
> > > won't boot. Anybody else have more luck?
> > 
> > Did you try with the two changes I suggested? Patch below.
> 
> No, I hadn't dug through mail yet. I'm away from the machine, will give
> it a try early next week. Thanks!

I just verified, and with those fixes I can boot a quad G5 here with:

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y


-Olof

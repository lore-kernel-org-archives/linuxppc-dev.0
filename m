Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 692BDDDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:19:24 +1100 (EST)
Date: Tue, 20 Feb 2007 00:19:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [PATCH 05/10] powermac: generic time suspend/resume
	code
In-Reply-To: <Pine.LNX.4.60.0702191046160.5056@poirot.grange>
Message-ID: <Pine.LNX.4.60.0702200016510.15773@poirot.grange>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.869369000@sipsolutions.net>
	<Pine.LNX.4.60.0702191046160.5056@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Feb 2007, Guennadi Liakhovetski wrote:

> On Mon, 5 Feb 2007, Johannes Berg wrote:
> 
> > This patch removes the time suspend/restore code that was done through
> > a PMU notifier in arch/platforms/powermac/time.c.
> > 
> > Instead, we introduce arch/powerpc/sysdev/timer.c which creates a sys
> > device and handles time of day suspend/resume through that.
> 
> I think there's a problem with this one. In my tests with this patch the 
> system time is incremented twice, so, looks like some code already takes 
> care about that. Maybe there's some very indirect code in generic rtc, but 
> I haven't found anything yet. Anyway, requires more investigation and, 
> probably, should not be included before we clarify this.

Ok, it has been a problem with my testing. ATM I don't know of any 
problems with it, so, please, consider my objections void.

Thanks
Guennadi
---
Guennadi Liakhovetski

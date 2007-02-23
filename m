Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7F58BDDE47
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 05:31:30 +1100 (EST)
Date: Fri, 23 Feb 2007 19:31:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: rtc suspend()/resume() restores system clock
In-Reply-To: <1172229450.3870.5.camel@johannes.berg>
Message-ID: <Pine.LNX.4.60.0702231927220.8712@poirot.grange>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
	<1172229450.3870.5.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Torrance <torrance123@gmail.com>,
	linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First, sorry for messing up the subject line.

On Fri, 23 Feb 2007, Johannes Berg wrote:

> On Thu, 2007-02-22 at 23:58 +0100, Guennadi Liakhovetski wrote:
> 
> > I think, we only want 1, right? And the latter seems to be more generic / 
> > platform independent? And as a side-effect, powermac would have to migrate 
> > to generic rtc:-)
> 
> Can we migrate all of powerpc to genrtc? But yes, I agree. Had enough to
> do though already to get suspend working :)

Johannes, is there any special meaning in "migrate all of powerpc to 
genrtc"? Or is it just porting every single rtc driver to the generic rtc 
API, moving it under drivers/rtc and adjusting its users or are there any 
global changes required to arch/powerpc? Linkstation is now happily using 
a driver under drivers/rtc, whereas originally it also had a "all special" 
driver, and the migration for me wasn't that difficult... Or is there more 
to do for other platforms?

Thanks
Guennadi
---
Guennadi Liakhovetski

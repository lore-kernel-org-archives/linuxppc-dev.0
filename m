Return-Path: <david-b@pacbell.net>
Received: from smtp110.sbc.mail.re2.yahoo.com (smtp110.sbc.mail.re2.yahoo.com
	[68.142.229.95]) by ozlabs.org (Postfix) with SMTP id 1A2DCDDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 13:24:55 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: several messages
Date: Thu, 22 Feb 2007 17:15:01 -0800
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0702222352460.6771@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702221715.03195.david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>,
	linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
	Torrance <torrance123@gmail.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 February 2007 2:58 pm, Guennadi Liakhovetski wrote:
> 
> I think, we only want 1, right? And the latter seems to be more generic / 
> platform independent? And as a side-effect, powermac would have to migrate 
> to generic rtc:-)

I'd certainly think that restoring the system clock should be, as much
as possible, in platform-agnostic code.  Like the generic RTC framework.

And hmm, that powermac/time.c file replicates other RTC code...

Minor obstacle:  removing the EXPERIMENTAL label from that code.

- Dave

Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 32A78DDF68
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 10:06:09 +1100 (EST)
Date: Tue, 11 Nov 2008 00:05:56 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
Message-ID: <20081111000556.0ae8323c@i1501.lan.towertech.it>
In-Reply-To: <200811101457.29051.david-b@pacbell.net>
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
	<200811101457.29051.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	David Woodhouse <dwmw2@infradead.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 10 Nov 2008 14:57:28 -0800
David Brownell <david-b@pacbell.net> wrote:

> Yeah, we should have one of these.  :)

 :) great! now let's see if we can get others
 to agree!
 

> A better default might be to update all the RTCs on the system.
> 
> I'm thinking of my trusty test-case here:  rtc0 is highly functional
> (including wake from RTC alarm) but not battery backed, while rtc1
> is battery backed but only tracks time.  NTP really needs to update
> both of them ... rtc0 since that's what's used most of the time,
> and also rtc1 since that's what actually *stores* the time during
> power off cycles.

 well, let's start with one... we all lived with one rtc until
 a couple of year ago :)
 
 
> > +static int rtc_systohc(struct rtc_time *tm)
> 
> I think "static" will lose, especially since ...

 wooops!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 295F5DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 09:11:58 +1100 (EST)
Date: Tue, 24 Feb 2009 23:11:54 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [rtc-linux] [PATCH/RFC 0/5] Generic RTC class driver
Message-ID: <20090224231154.60ba18d6@i1501.lan.towertech.it>
In-Reply-To: <1235511327.18632.73.camel@macbook.infradead.org>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, David@ozlabs.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009 06:35:27 +0900
David Woodhouse <dwmw2@infradead.org> wrote:

> > So you want us to kill the ppc_md.[gs]et_rtc_time() [ppc], mach_hwclk() [m68k],
> > mach_gettod() [m68knommu] (and probably a few other) abstractions, and move all
> > RTC code out of arch/ into seperate drivers under drivers/rtc/ instead?
> 
> That's the ideal... although did we get NTP sync working again yet?

 not yet. we're close but I've been very busy :(
 
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

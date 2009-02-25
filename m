Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 0136DDDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 21:00:14 +1100 (EST)
Date: Wed, 25 Feb 2009 11:00:13 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [rtc-linux] [PATCH/RFC 0/5] Generic RTC class driver
In-Reply-To: <1235514727.18632.93.camel@macbook.infradead.org>
Message-ID: <alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, David@ozlabs.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009, David Woodhouse wrote:
> On Tue, 2009-02-24 at 23:11 +0100, Alessandro Zummo wrote:
> > On Wed, 25 Feb 2009 06:35:27 +0900
> > David Woodhouse <dwmw2@infradead.org> wrote:
> > 
> > > > So you want us to kill the ppc_md.[gs]et_rtc_time() [ppc], mach_hwclk() [m68k],
> > > > mach_gettod() [m68knommu] (and probably a few other) abstractions, and move all
> > > > RTC code out of arch/ into seperate drivers under drivers/rtc/ instead?
> > > 
> > > That's the ideal... although did we get NTP sync working again yet?
> > 
> >  not yet. we're close but I've been very busy :(
> 
> I know the feeling.
> 
> Once that's working, we can convert individual PPC platforms over,
> removing the routines from the ppc_md and creating a generic RTC driver
> instead. PA Electra is already like that -- because it wasn't a
> regression there to have broken NTP sync. But the others need to wait.

I didn't know NTP was broken with RTC class drivers?

So we should actually keep on using genrtc instead of rtc-ppc/rtc-generic for
now? ;-)

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

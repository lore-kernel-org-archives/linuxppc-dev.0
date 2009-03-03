Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFDF1DE010
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 06:27:19 +1100 (EST)
Date: Wed, 4 Mar 2009 04:06:10 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
Message-ID: <20090303190609.GB6907@linux-sh.org>
References: <20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
	<alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
	<20090225111836.621412c1@i1501.lan.towertech.it>
	<20090227185514.GA1071@linux-m68k.org>
	<alpine.LRH.2.00.0903021051040.25117@vixen.sonytel.be>
	<20090302110310.35af50ea@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0903021116450.25117@vixen.sonytel.be>
	<20090302120950.0d35e06c@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0903031121280.31985@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.0903031121280.31985@vixen.sonytel.be>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 03, 2009 at 11:41:23AM +0100, Geert Uytterhoeven wrote:
> So would you accept a patch series that:
>   1. Adds the missing module aliases to rtc-parisc (which is a bugfix),
>   2. Moves the platform device creation out of rtc-ppc and into arch-specific
>      code (which is also a bugfix),
>   3. Consolidates rtc-parisc and rtc-ppc into rtc-generic (which is a cleanup),
>   4. Makes rtc-generic dependent on PARISC, PPC, and M68K (the existing
>      [sg]et_rtc_time() users):
>        a. without introducing ARCH_HAS_GENERIC_RTC,
>        b. with a big fat warning in the Kconfig comment not relaxing the
>           dependencies, as it's supposed to go away.
>   4. Converts the PS3 RTC support into a separate driver, called rtc-ps3
>      (as a bonus ;-)
> 
> ? If yes, I'll cook it up.
> 
> Other RTC platform support can be converted into separate drivers later.
> 
Did you miss the rtc-firmware thread?

http://groups.google.com/group/rtc-linux/browse_thread/thread/53e8d98966048f66/1d730cb4aa2f85f0?lnk=gst&q=rtc-firmware#1d730cb4aa2f85f0
http://groups.google.com/group/rtc-linux/browse_thread/thread/b3d10115c7e147f2/cb9c1530d9c3a433?lnk=gst&q=rtc-firmware#cb9c1530d9c3a433

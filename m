Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id A5E87DDF6B
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 21:03:16 +1100 (EST)
Date: Mon, 2 Mar 2009 11:03:10 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
Message-ID: <20090302110310.35af50ea@i1501.lan.towertech.it>
In-Reply-To: <alpine.LRH.2.00.0903021051040.25117@vixen.sonytel.be>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
	<alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
	<20090225111836.621412c1@i1501.lan.towertech.it>
	<20090227185514.GA1071@linux-m68k.org>
	<alpine.LRH.2.00.0903021051040.25117@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux/m68k <linux-m68k@vger.kernel.org>,
	Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org,
	Development <linux-kernel@vger.kernel.org>, David,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux,
	David@ozlabs.org, Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Mar 2009 10:54:14 +0100 (CET)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> Indeed. You can have a working RTC class driver for lots of hardware by just
> writing ca. 100 lines of code on top of the generic framework.

 That's true, but we would then have two generic frameworks. And one
 of them will have its code scattered all around the kernel.

 So you either use the old rtc framework, which is perfectly functional,
 or you move to the new rtc lass and write the drivers.

 Layering a generic framework over another generic framework
 is quite a nonsense . 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

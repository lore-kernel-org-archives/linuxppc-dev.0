Return-Path: <macro@linux-mips.org>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [213.58.128.207])
	by ozlabs.org (Postfix) with ESMTP id 073AEDDDA1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 04:34:15 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:9097 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S20808785AbZB0RRg (ORCPT <rfc822;linuxppc-dev@ozlabs.org>);
	Fri, 27 Feb 2009 17:17:36 +0000
Date: Fri, 27 Feb 2009 17:17:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
In-Reply-To: <20090225111836.621412c1@i1501.lan.towertech.it>
Message-ID: <alpine.LFD.1.10.0902270142360.22096@ftp.linux-mips.org>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
	<alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
	<20090225111836.621412c1@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	David@ozlabs.org, Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Geert.Uytterhoeven@sonycom.com, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009, Alessandro Zummo wrote:

> > I didn't know NTP was broken with RTC class drivers?
> > 
> > So we should actually keep on using genrtc instead of rtc-ppc/rtc-generic for
> > now? ;-)
> 
>  broken here means that the kernel won't save the time to the hardware
>  rtc every 11 minutes as it used to do. normal NTP operations are unaffected.

 I posted patches to support it last year -- from your answer I infer they 
were not applied in the end.  I'll see if I can try to refresh them and 
push again next time I'll be upgrading my kernel.

  Maciej

Return-Path: <SRS0+20b0e43a3c9080e2d54c+2024+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1FF8DDF96
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 00:59:57 +1100 (EST)
Subject: Re: [PATCH 6/7] powerpc: Hook up rtc-generic, and kill rtc-ppc
From: David Woodhouse <dwmw2@infradead.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain
Date: Mon, 09 Mar 2009 13:59:41 +0000
Message-Id: <1236607181.572.180.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 14:26 +0100, Geert Uytterhoeven wrote:
> PowerPC has been a long time user of the generic RTC abstraction, so hook up
> rtc-generic:
>   - Create the "rtc-generic" platform device if ppc_md.get_rtc_time is set,
>   - Kill rtc-ppc, as rtc-generic offers the same functionality in a more
>     generic way, and supports autoloading through udev.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Acked-By: David Woodhouse <David.Woodhouse@intel.com>

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

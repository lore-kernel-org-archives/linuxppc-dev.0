Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F33C0DE1D7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 15:16:27 +1100 (EST)
Subject: Re: [PATCH 6/7] powerpc: Hook up rtc-generic, and kill rtc-ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1236607181.572.180.camel@macbook.infradead.org>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236607181.572.180.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 15:15:23 +1100
Message-Id: <1236744923.7086.41.camel@pasglop>
Mime-Version: 1.0
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 13:59 +0000, David Woodhouse wrote:
> On Mon, 2009-03-09 at 14:26 +0100, Geert Uytterhoeven wrote:
> > PowerPC has been a long time user of the generic RTC abstraction, so hook up
> > rtc-generic:
> >   - Create the "rtc-generic" platform device if ppc_md.get_rtc_time is set,
> >   - Kill rtc-ppc, as rtc-generic offers the same functionality in a more
> >     generic way, and supports autoloading through udev.
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> Acked-By: David Woodhouse <David.Woodhouse@intel.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

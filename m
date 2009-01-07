Return-Path: <wim@iguana.be>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id 37556DE13B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 18:56:28 +1100 (EST)
Date: Wed, 7 Jan 2009 08:56:21 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] watchdog: Basic support for GE Fanuc's FPGA based
	watchdog timer
Message-ID: <20090107075621.GD11454@infomag.infomag.iguana.be>
References: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
	<20081110123125.8608.2251.stgit@ubuntu8041.localdomain>
	<A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Martyn Welch <martyn.welch@gefanuc.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

> >drivers/watchdog/Kconfig   |    6 +
> >drivers/watchdog/Makefile  |    1
> >drivers/watchdog/gef_wdt.c |  333 +++++++++++++++++++++++++++++++++++ 
> >+++++++++
> >3 files changed, 340 insertions(+), 0 deletions(-)
> 
> Wim,
> 
> Any status of acceptance of this?

I started reviewing it on sunday. It looks OK so you can expect inclusion in my -next tree this week.
A couple of days later I would like to forward it to Linus for mainline inclusion. It would like to have it in 2.6.29.

Kind regards,
Wim.

Return-Path: <SRS0+a7d93ed5023a180b967e+1900+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54C84DDDE0
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 09:18:51 +1100 (EST)
Subject: Re: rtc-ppc
From: David Woodhouse <dwmw2@infradead.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
In-Reply-To: <20081105021901.49dffc3e@i1501.lan.towertech.it>
References: <20081105021901.49dffc3e@i1501.lan.towertech.it>
Content-Type: text/plain
Date: Wed, 05 Nov 2008 23:18:46 +0100
Message-Id: <1225923526.3882.3.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-05 at 02:19 +0100, Alessandro Zummo wrote:
>   I was checking a few drivers for compliance and noticed that
>  the rtc-ppc driver registers a platform device instead of
>  a platform driver.
> 
>   Wouldn't be possible to have the ppc arch doing the device
>  thing and cleanup the driver?

It would be possible, yes -- but it would be better to have the various
PPC platforms just register RTC-class devices _directly_, and ditch the
RTC bits from ppc_md altogether.

I think we're waiting until the RTC class works with NTP before we can
contemplate that, though.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

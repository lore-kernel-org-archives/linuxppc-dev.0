Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 636A4DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 20:06:56 +1000 (EST)
In-Reply-To: <1182298510.5674.358.camel@rhino>
References: <1182298510.5674.358.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c5941587e5e4cb07efbc86845c9a15a4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] Create add_rtc() function to enable the RTC CMOS driver
Date: Wed, 20 Jun 2007 12:06:48 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This creates a function to register the platform device based on the 
> RTC
> device node and verifies that the RTC port against the hard-coded value
> in asm/mc146818rtc.h.  It also sets the RTC to 24-hr mode as 12-hr mode
> is not currently supported by the driver.

The 24h thing should be set in the driver itself.  Does the
driver handle binary vs. decimal mode btw?  If not, you'll
want to do the analogue thing for that.


Segher

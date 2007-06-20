Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 432DFDDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 02:21:15 +1000 (EST)
Subject: Re: [PATCH v2] Create add_rtc() function to enable the RTC CMOS driver
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <c5941587e5e4cb07efbc86845c9a15a4@kernel.crashing.org>
References: <1182298510.5674.358.camel@rhino>
	<c5941587e5e4cb07efbc86845c9a15a4@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 09:21:13 -0700
Message-Id: <1182356473.5674.375.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-20 at 12:06 +0200, Segher Boessenkool wrote:
> > This creates a function to register the platform device based on the 
> > RTC
> > device node and verifies that the RTC port against the hard-coded value
> > in asm/mc146818rtc.h.  It also sets the RTC to 24-hr mode as 12-hr mode
> > is not currently supported by the driver.
> 
> The 24h thing should be set in the driver itself.  Does the
> driver handle binary vs. decimal mode btw?  If not, you'll
> want to do the analogue thing for that.
> 

OK, I'll look into putting the 24h fix into the driver.

It looks like binary mode is also not supported, so I'll add a fix for
that as well.

Thanks,

--Wade

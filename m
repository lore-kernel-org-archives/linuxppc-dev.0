Return-Path: <jangiels@speakeasy.net>
Received: from mail3.speakeasy.net (mail3.speakeasy.net [216.254.0.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4C4E2BF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 03:29:12 +1000 (EST)
From: Jeff Angielski <jangiels@speakeasy.net>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <B9C9EB8C-2378-11D9-9860-003065F9B7DC@embeddededge.com>
References: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
	<721875C6-236D-11D9-9860-003065F9B7DC@embeddededge.com>
	<1098371711.3508.9.camel@nighteyes.localdomain>
	<B9C9EB8C-2378-11D9-9860-003065F9B7DC@embeddededge.com>
Content-Type: text/plain
Message-Id: <1098379749.8619.16.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Thu, 21 Oct 2004 13:29:09 -0400
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: SCC UART stalling/hanging - progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-21 at 11:49, Dan Malek wrote:
> On Oct 21, 2004, at 11:15 AM, Jeff Angielski wrote:
> 
> > No flow control.  8N1 at 230kbps on SCC2 in UART mode.
> 
> WTF?  Does it work at other baud rates, like 115200?

I have seen the SCC stall with 57600 and 115200 as well, but not as
often.  I have not test anything slower than that.

> If you just transmit out the port and watch on an o'scope
> or something, does it keep running?  

The data on the tx/rx lines on the scope go idle at the same time the
software thinks the SCCs have gone idle.

> When it fails, how long does it usually run?

Unfortunately I have not discovered any pattern to the madness. 
Sometimes it works fine for MBs of data and sometimes it stalls after
only 30k bytes worth of data.  The only thing of note is that it seems
to happen more often with the faster baud rate.

Jeff Angielski

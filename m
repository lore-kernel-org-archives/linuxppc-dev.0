Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD2192BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 06:03:24 +1100 (EST)
In-Reply-To: <20050105174838.GF4213@smtp.west.cox.net>
References: <1102585377.41b81e218d6df@webmail.televes.com:443>
	<20050105174838.GF4213@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <71A72D18-5F4C-11D9-A045-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 5 Jan 2005 14:03:11 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: alebas@televes.com, linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.10 running on mpc8272ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 5, 2005, at 12:48 PM, Tom Rini wrote:

> Indeed.  While I had a PQ2FADS for a bit, I had to do that as well.
> Kumar, what/why is that needed exactly?  Did I screw up in re-working
> the 82xx init stuff and it needs to happen a bit later in boot?

I don't understand the what/why question, but that has never stopped
me from providing answers in the past :-)

So, In 2.6, and I think in some of the 2.4 cpm2 stuff, we no longer
automatically map any of the hardware IO resources for common
access like I used to do in the past.  If you want to access the
BCSR, you need to make sure it is ioremap()'ed in your driver before
you make the access.  Was that the question, or was it that
the BCSR should have been set someplace outside of the
driver for the serial port to work?


	-- Dan

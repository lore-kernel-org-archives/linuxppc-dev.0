Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82DE1DDEBA
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 02:02:53 +1000 (EST)
In-Reply-To: <1179630190.32247.534.camel@localhost.localdomain>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<1179500217.20519.53.camel@imap.mvista.com>
	<464DC0DC.7050809@ru.mvista.com>
	<1179502773.20519.56.camel@imap.mvista.com>
	<17998.28659.702653.237011@cargo.ozlabs.ibm.com>
	<1179628991.20925.2.camel@imap.mvista.com>
	<1179630190.32247.534.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <995a4a7a4cada5604be7b30dcce8eb81@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Sun, 20 May 2007 18:02:46 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In fact, while it's never worded explicitely in the spec, it's always
> been strongly in the "spirit" of the architecture that the timebase and
> decrementer have a constant frequency.

The architecture mentions varying time base frequencies,
and how to deal with this, actually.  It makes no
recommendations one way or the other.

Fixed frequencies are easier for almost everything of
course :-)

> This is why processors like the
> 970 allow for an external sourcing for when they are used in setups
> where the various clocks are slewed for power management.

Clock spreading on the core clock is the bigger problem,
lack of accuracy on the order of 1% is unacceptable for
certain applications.


Segher

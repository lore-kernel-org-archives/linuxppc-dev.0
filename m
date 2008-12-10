Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id 39B24DDF6A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Dec 2008 01:43:59 +1100 (EST)
Received: by ewy13 with SMTP id 13so889542ewy.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 06:43:57 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: monstr@seznam.cz
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <493D2B22.4000601@seznam.cz>
	<493ED4B6.7010605@dlasys.net> <493F89F2.60702@seznam.cz>
	<87iqpsme9j.fsf@macbook.be.48ers.dk> <493FD3EC.3060305@seznam.cz>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 10 Dec 2008 15:43:39 +0100
In-Reply-To: <493FD3EC.3060305@seznam.cz> (Michal Simek's message of "Wed\,
	10 Dec 2008 15\:36\:28 +0100")
Message-ID: <87wse8m6p0.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dhlii@dlasys.net, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Michal" == Michal Simek <monstr@seznam.cz> writes:

Hi,

 >> Why? Have you swapped your A0 / A1?

 Michal> I found that ml40x designs have different connection that
 Michal> ml505 usb design. This is no problem for me. But I think that
 Michal> in David case is that problem.

OK. If this is something common, then maybe we should add support for
it in the driver?

 Michal> We used 2.6.20 kernel because we have this kernel well tested.
 Michal> I found where the problem was.

Ahh, what was it?

 Michal> Thanks for your driver and help,

You're welcome.

-- 
Bye, Peter Korsgaard

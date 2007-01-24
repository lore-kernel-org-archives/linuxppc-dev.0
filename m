Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CFD09DDF36
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 07:49:46 +1100 (EST)
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: JTAG emulator for MPC8548E (v2) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Jan 2007 08:57:19 +0100."
	<200701240857.19428.laurent.pinchart@technotrade.biz>
Date: Wed, 24 Jan 2007 21:49:44 +0100
Sender: wd@denx.de
Message-Id: <20070124204944.172BB353BC5@atlas.denx.de>
Cc: "Morrison,
    Tom" <tmorrison@empirix.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200701240857.19428.laurent.pinchart@technotrade.biz> you wrote:
>
> The new unit works *mostly* fine. No debugging issue (not that I use it that 
> much anyway, now that the board boots Linux), but still a flash programming 
> issue. Programming the target parallel NOR flash works in slow JTAG mode, but 
> not in faster mode using the internal workspace. I reported the problem 

This may as well be a misconfiguration in your config file, like
setting wrong flash timings.

> several months ago and still haven't received any solution. It might not be 
> Abatron's fault, the French distributor might not have reported the problem 
> to them. Abatron people speak German only, and will not respond to e-mails 
> written in English (nor will they talk to you on the phone, they just hang 
> up).

I cannot confirm this. On contrary. Abatron's support is one  of  the
best  I've  ever  seen,  and I have seen a few. And of course you can
send messages in  English  to  support@abatron.ch,  and  you  do  get
replies.  And  they  do  answer  the phone (in German and in English,
too).

> The BDI-2000 is a nice product, but has a few bugs, is IMHO overprized and has 
> one of the worst support service I've had to deal with.

Hm... we have about 15 such devices in daily use. I don't doubt  your
report, but you must have had really bad luck. This is NOT the normal
situation with Abatron or the BDI.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In Nature there are neither rewards nor punishments, there are conse-
quences.                                            -- R.G. Ingersoll

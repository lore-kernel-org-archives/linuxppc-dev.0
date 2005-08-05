Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 1B69167F01
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 07:20:04 +1000 (EST)
To: Igor Marnat <marny@rambler.ru>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Aug 2005 15:11:05 +0400."
	<19013128171.20050805151105@rambler.ru>
Date: Fri, 05 Aug 2005 23:19:29 +0200
Sender: wd@denx.de
Message-Id: <20050805211929.B526E352B73@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: what to use to connect to JTAG/BDM port on PPC405EP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <19013128171.20050805151105@rambler.ru> you wrote:
>
> I have EVB based on PPC 405 EP (PPChameleon EVB). It has JTAG port.
> What JTAG device can I use to connect to the board? I've found BDI2000

You found The Right Thing (TM). Use a BDI2000.

> device, for example, but it costs as N times as the EVB does

It's worth the price.

> (approximately). It seems unreasonable for me. Is it possible to make such a device or to find
> find the cheaper one? We found several schemes of how to make connector BDM-parallel
> port. Is it possible to do such a thing for PPC 405EP?

It's simple to rig up the required electrical interface and attach it
- say - to the parallel port of a standard PC. However, to  make  any
use  of  it,  you  have  to  understand which data to send and how to
interpret the results. This requires signing a NDA with IBM / AMCC  /
Freescale.  Assuming  you get the required information, it then means
quite a lot of hacking to get some working code that interfaces  with
a  standard debugger like GDB. And you will not be able to share your
code  with  others,  as  the  NDA  explicitely  prevents   you   from
implementing  it  in  any  form  of  open  source  software. You will
completely on your own there.

In the meantime the BDI user has completed 5 more real projects.


Go for a BDI.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
SW engineering is a race between programmers trying  to  make  better
idiot-proof programs and the universe producing greater idiots.

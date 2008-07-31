Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s15.bay0.hotmail.com (bay0-omc2-s15.bay0.hotmail.com
	[65.54.246.151]) by ozlabs.org (Postfix) with ESMTP id A0F30DDF4D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 00:31:00 +1000 (EST)
Message-ID: <BAY101-W540C823A709A6C5F2E815FBE7C0@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Lost time?
Date: Thu, 31 Jul 2008 14:30:58 +0000
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi everyone=2C

After a move from the ppc (v2.6.19) branch to the powerpc (v2.6.25) we've s=
potted a bit of an annoying problem. It looks like we loosing system time o=
n a running system. About 0.6sec per minute.

It's not hardware=2C Old kernel was rock solid with regards to time. Even w=
ith a stripped down kernel (minimum device drivers=2C modules=2C and IRQ's)=
 we still see time loss. During kernel debug all tick calculations looks re=
asonable.

Anyone have any ideas=2C obvious suspects=2C or pointers where to go and lo=
ok?

Hardware is a 500Mhz ppc 440EPx based system.

 Regards

_________________________________________________________________
100=92s of Nikon cameras to be won with Live Search
http://clk.atdmt.com/UKM/go/101719808/direct/01/=

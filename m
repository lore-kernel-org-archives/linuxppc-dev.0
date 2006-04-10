Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 2057267A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 05:58:16 +1000 (EST)
Subject: GPIO endianness on MPC8349
From: Ben Warren <bwarren@qstreams.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 10 Apr 2006 15:48:21 -0400
Message-Id: <1144698501.972.103.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm a noobie to this CPU, and am utterly confused with how the bits are
ordered on the GPIO ports.  I imagine it's the same as all Freescale
PPCs, but who knows.  Anyway...

Using an MPC8349MDS eval board, I have one LED to play with.  From the
schematic, it's connected to GPIO1[1].  From other processors that I've
worked with, I would have expected to toggle it with either 0x40000000
(IBM 405) or 0x00000002 (68360).  Nope.  To make this bit move, I mess
with bit 0x00000040 in the appropriate DAT register.  This leads me to
believe that either the bit ordering is something
like ...89abcdef01234567 (sorry for the confusing notation, but
hopefully it makes sense) or the schematic has a typo.  Since I'm trying
to write a generic GPIO handler, I'd like to have a little confidence in
my extrapolation from a single point.

Can anybody shed some light on this?

thanks,
Ben

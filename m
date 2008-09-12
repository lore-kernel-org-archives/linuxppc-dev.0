Return-Path: <MCarey@nearfield.com>
Received: from webmail.nearfield.com (webmail.nearfield.com [63.200.6.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "webmail.nearfield.com", Issuer "NSI" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C0342DDED7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Sep 2008 08:18:43 +1000 (EST)
Message-Id: <48CA8840.9124.0071.0@nearfield.com>
Date: Fri, 12 Sep 2008 15:18:24 -0700
From: "Michael Carey" <MCarey@nearfield.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Support for multiple consoles
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am using ELDK 3.1.1 on a mpc5200 platform with a CoralP pci card.  I =
also connecting a keyboard and mouse.  When I compile the code without a =
virtual console, then my terminal session rules.  I can type with my =
terminal keyboard and everything seems fine.

When I compile with a virtual console, then my embedded lcd displays text =
and my usb keyboard works.  Everything is great.

Is there a way to switch back and forth between my embedded console to my =
terminal console?  I have tried console=3DttyS0, but that does not seem to =
do anything.
When I list my devices: 'ls /dev' I only get tty, ttyS0, ttyS1, and ttyS2. =
 I do not see a tty0.

Is there a way to run multiple consoles on this configuration? If not, =
does to ELDK 4.x support this?


Thanks in advance for any information or guidance.

Michael Carey

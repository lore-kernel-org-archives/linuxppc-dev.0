Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 23A1C679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 05:42:42 +1000 (EST)
To: achim.machura@berghof.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Jun 2005 15:28:40 +0200."
	<000d01c5701b$d08210e0$34f1ff0a@beint.local>
Date: Mon, 13 Jun 2005 21:42:07 +0200
Sender: wd@denx.de
Message-Id: <20050613194212.A01BDC1512@atlas.denx.de>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: Re: UART TL 16C550C on custom mpc5200 board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000d01c5701b$d08210e0$34f1ff0a@beint.local> you wrote:
> 
> i'm working on a custom 5200 board with kernel 2.4.25.
> I have to integrate an UART 16C550C in /dev/ttyXX.
> Does everyone knows an existing driver i can modify for use with this chip?

You don't have to modify much; just  configure  the  interrupts,  add
definitions  of  STD_SERIAL_OP  for  all  ports to your board file in
arch/ppc/platforms/, and make sure that there is no conflict in major
numbers between drivers/char/serial.c and any other serial driver  in
your system.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A woman should have compassion.
	-- Kirk, "Catspaw", stardate 3018.2

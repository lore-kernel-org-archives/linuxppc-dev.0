Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DB5CD67A7B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jan 2005 19:51:29 +1100 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 6DF4A403F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jan 2005 09:51:29 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Mon, 31 Jan 2005 09:51:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200501310951.24600.david.jander@protonic.nl>
Subject: The RS485 driver problem...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

If you want to connect a RS485 transceiver to a normal UART, you always have 
the problem of dealing with enabling/disabling transmitter and recveiver. I 
have seen hardware that misuses RS-232 hardware handshaking lines (RTS/CTS) 
for this purpose. What I have not been able to find is a linux driver or 
software solution to this problem.

Has anybody used the CPM uarts (or even a standard 16C550 uart) for this 
purpose? How?

Greetings,

-- 
David Jander
Protonic Holland.

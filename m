Message-Id: <200102062306.f16N67B22187@denx.denx.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Status of hardware handshake in 8xx SCC driver?
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Wed, 07 Feb 2001 00:06:07 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

has anybody spend some work on or even tested the hardware  handshake
code in the MPC8xx UART driver (for SCC)?
Is the "#ifdef modem_control" code working? Are  there  any  improve-
ments / patches?

Thanks in advance,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <35C119252057D511BB9F0003476BF8A298BE4A@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPC 750 and DEC Tulip driver...
Date: Fri, 8 Feb 2002 12:26:14 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using 2.4.17 kernel version on my custom PowerPC 750 board.

I can plugin any PCI cards (PMC actually) to my board and use it. I tried to
use 92559ER and works fine. But when I use the DEC 2114x tulip, it gives me
watchdog timeouts. I am attaching the log of errors with this email.

Can some one suggest me what this Watchdog timeout is about?. That too
especially only when using the tulip driver.

Thanks,
-- Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Klemen Porenta <klemen.porenta@siol.net>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: FCC transmit underrun 8265
Date: Fri, 2 Jul 2004 11:54:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Message-Id: <20040702095429.YGXQ1092.pegasus@[10.10.10.22]>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm porting the embedded 2.4.26-pre5 kernel to our board. This board has
MPC8265 (silicon 2K25A) in PCI mode.

I have problems on ethernet (FCC2). U-boot works fine. On transmit I got underrun error if buffer is bigger than 62 bytes (in ethereal I can see ARP packet). Receive is working OK.  I have the same clock configuration as in U-Boot.

Any ideas?

Thanks, Klemen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

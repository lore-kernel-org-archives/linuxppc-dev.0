Message-ID: <20010819190624.51260.qmail@web20105.mail.yahoo.com>
Date: Sun, 19 Aug 2001 12:06:24 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Using IDMA1 ( or IDMA2 ) on 860
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

On my board I am using SCC1 and SCC2 for 10 Mbps
ethernets.

I am also using SMC1 and SMC2 for some 9600 baud
serial connection.

I am also planning on using IDMA1 for some DMA. My
chip is a 860P are there any problems with Parameter
ram conflict?

All SCC1, SCC2, SMC1 and SMC2 work fine. But my IDMA1
CPM interrupt handler never gets invoked, on hardware
side I do see the DREQ line going low and I have
verified that RCCR register for CPM is set correctly
to level trigger the interrupt.

Any ideas on why IDMA1 interrupt handler is not
getting invoked?

ANY HELP !!!!

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: "Jim Lin" <jimmlin@solomon.com.tw>
To: "linuppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: Poor 8xx SCC Ethernet mode performence..
Date: Tue, 16 Jul 2002 17:37:39 +0800
Message-ID: <NFBBLLKCILMGHKJGDFGHEEMACCAA.jimmlin@solomon.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi .

I  was testing SCC ethernet performance at our 850 custom board and found somting interesting.

1. Tested FTP  Transfer about 20MB file with 10T hub  I got  about 250 k bps (someting poor ..)
2. and I found the hhl20 arch/ppc/8xx_io/enet.c source code NOT enable full duplex ..
     and I had  pmsr  added SCC_PMSR_FDE | SCC_PMSR_LPB .. and compiling , tested FTP Transfer again.
     I got about 200 Kbps!

I do not understand what is happen? Has anyone experience this?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

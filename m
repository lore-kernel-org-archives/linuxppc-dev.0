Message-Id: <sba745ea.073@mail.frequentis.com>
Date: Tue, 18 Sep 2001 13:02:06 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860(T) uart SCCs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hallo!
Iwork with an custom board MPC860T kernel 2.4.5. I will use all 4 SCC as uart RS485/RS232. The problem is, that SCC1 and SCC2 works fine and SCC3 and SCC4 not:
I mapped SCC1 to BRG1 (ttyS0) SCC2 to BRG2 (ttyS1)....
SCC3 and SCC4 doesn't generate any interrupt. If I write in a loop something to Port ttyS2 for example the driver fills the buffer set the Ready bit in the bd, and nothing else happens, no output. When the wrap happens the Ready bit is still set, and the program hangs up. It looks like the SCC won't send any data.

sicr is set to 0x1b120900 so I think there is no fault.

anyone any ideas?

Thanks for help

Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

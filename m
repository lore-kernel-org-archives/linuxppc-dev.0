Message-ID: <01139FC052A0D411900B00508B9535FC0F0D2864@ZCH07EXM04.corp.mot.com>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: JTAG debug mechanism
Date: Fri, 13 Aug 2004 13:44:43 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I know this question is off topic, but I can't find a better place to ask.  I will be grateful if anyone can give me a hint or direct me to a reference.

As we know PowerPC use JTAG to debug CPU, which implements a Boundary-Scan mechanism.  It can manipulate any input/output signals of the CPU by a serial shift/scan process.  But my question is how it can read/write the core registers and system memory as implemented by most JTAG emulators.

Thanks,
Leo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

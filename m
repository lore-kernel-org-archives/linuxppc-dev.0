From: "Nicolas-Peter Pohland" <pohland@snom.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Timebase and decrementer stop after CPU gets warmer
Date: Wed, 8 Nov 2000 20:31:34 +0100
Message-ID: <HEEJLLLEHBIOHDGILMPNGEAKCAAA.pohland@snom.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using custom board with 855Ts version D3. The 50Mhz version runs fine
but the 66 Mhz version hangs or start to hang in the delay loop after a
while. This happens immediately, if the CPU is warm. Obviously the timer is
not decrementing.
The TBSCR[TBE] bit is being set (yes the key register is used BEFORE the
value is being written.) 860TD3s do not have this problem either (66 Mhz
version).

Any ideas ? Do you think it is a PLL supply voltage problem or a CPU
"feature" ?

Thanx in advance for any helpful remarks,
Nicolas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

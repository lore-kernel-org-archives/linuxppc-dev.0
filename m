Date: Thu, 20 Apr 2000 17:55:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MiniDin9 serial pin outs to talk to DB9 UPS?
In-Reply-To: <38FF1565.99905655@chpc.utah.edu>
Message-ID: <Pine.LNX.4.10.10004201742100.19482-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The other PowerMac 7500 (MiniDin9) pin outs are (and I had a hard time
> finding this info from an Apple web site):
>
> pin 1: SCLK(out)   ---- I'm assuming this is DTR
> pin 2: Sync(in)/SCLK(in) ---- I'm assuming this is CTS

I recall two pins on the serial port labeled as Handshake in/out which
would translate to RTS/CTS (the other pair is DTR/DSR device status not
handshake). The SCLKs are sync. external clock lines for LocalTalk
perhaps, the Sync would correspond to RI on a modem line.

I'll have to look up the 'standard' pinout for that connector elsewhere
but I recall Apple left out one pin usually needed for hardware
handshaking.

> pin 6: TxD+
> pin 7: Wakeup/TxHS ---- I'm assuming this is DCD
> pin 8: RxD+
> pin 9: +5V (power to pod) ---- what's a 'pod'?
>
> I was told that the PC serial cable connects similarly sparsely except
> that pins 4 and 6 on the PC end are jumpered together. That seems to be
> a short between TxD+ and DTR. I tried doing the same for the

Nope, you need to connect RTS and CTS, and sometimes DTR and DSR and DCD
are also connected together. C onnecting DTR and TxD will only confuse the
serial driver.

> Mac MiniDin9 by jumpering MiniDin9 pins 1 and 6 together. This didn't
> work. Nor did jumpering 1 to 8 or 1 to 7.

Try connecting 1 and 2 ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

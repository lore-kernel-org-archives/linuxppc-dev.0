Message-ID: <391FE782.7BB93BA3@switchboard.ericsson.se>
Date: Mon, 15 May 2000 14:03:14 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Coenraad Jacobsz <cjj@research.canon.com.au>
CC: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SCC1 Serial on 855T
References: <391FB289.D27AD998@research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

The SCC support is pretty limited in uart.c...
So - no modem control, and receive works pretty bad.

To get modem control to work as good as in serial.c you will
need to hook interrupts on the status pins and do much more.

I am working on a new serial driver with support for modem control on SCCs.
It's not finished yet, I'm busy with some other things right now.
I've been able to control a modem with modem control at 115200 bps with SCC2.

I suggest you wait a while...

Cheers /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

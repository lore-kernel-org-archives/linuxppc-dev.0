Date: Thu, 16 Nov 2000 15:10:19 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Leonhard Jaschke <jaschke@inf.ethz.ch>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 internal modem
In-Reply-To: <3A13B00C.988212F9@inf.ethz.ch>
Message-ID: <Pine.LNX.4.10.10011161509320.28935-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >
> > When I send something to ttyS0 I see from /proc/interrupts
> > that interrupt counters for SCC change. Perhaps the serial
> > interface works, but the modem is a winmodem... :(
>
> I have a problem with the internal modem on the dual G4 450. When I try
> to use minicom on /dev/ttyS0 it tells me that it can't find that device.

Get a more recent minicom build. The device open timeout in minicom was
shorter than the modem powerup delay.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

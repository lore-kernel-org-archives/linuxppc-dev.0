Message-ID: <XFMail.001117094627.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10011161509320.28935-100000@opal.biophys.uni-duesseldorf.de>
Date: Fri, 17 Nov 2000 09:46:27 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: G4 internal modem
Cc: linuxppc-dev@lists.linuxppc.org, Leonhard Jaschke <jaschke@inf.ethz.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> > When I send something to ttyS0 I see from /proc/interrupts
>> > that interrupt counters for SCC change. Perhaps the serial
>> > interface works, but the modem is a winmodem... :(
>>
>> I have a problem with the internal modem on the dual G4 450. When I try
>> to use minicom on /dev/ttyS0 it tells me that it can't find that device.
>
> Get a more recent minicom build. The device open timeout in minicom was
> shorter than the modem powerup delay.

So the modem works and the problem is minicom ?!?  Hm :/



Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

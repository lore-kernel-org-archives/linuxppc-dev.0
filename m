Date: Thu, 2 Nov 2000 18:13:48 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: cl.en@gmx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <19340927090721.10201@192.168.1.2>
Message-ID: <Pine.LNX.4.10.10011021740360.31372-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Well, the kernel sleep code is supposed to take care of that, but
> apparently, that code is also causing the panic...
>
> Michael, any clue ?

Can't reproduce the panic - both with and without the wakebay app, my
2.2.18pre17-ben1 fails to hang. No bad things happen with the CD mounted,
either.

So what should have happened? Crash (panic message), or plain hang?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

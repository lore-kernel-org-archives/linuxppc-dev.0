Date: Fri, 29 Sep 2000 21:27:02 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Lanners <mlan@cpu.lu>
cc: gewrgiou@imbc.gr, rshapiro@bbn.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <200009282107.XAA00763@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10009292124490.7428-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Accessing resources that are not enabled, yes, you get a machine check,
> because the device will not answer your accesses, so the bus will hit a
> timeout, which will be signaled to the processor (was that a PCI master
> abort?), in a way that the processor will throw a machine check
> exception.
>
> And that machine check exception is not recovered from (would that even
> be possible?), hence a plain old kernel panic.

If you do the access protected by something as used by copy_from/to_user
it should be possible to catch the exception (assuming a machine check
will initiate the same exception processing as a bus error does. I'm no
PPC expert :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

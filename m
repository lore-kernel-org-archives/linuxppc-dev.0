Date: Thu, 1 Mar 2001 15:05:27 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: u64 fun and PCI DMA not working for things behind bridges?
In-Reply-To: <19350124073525.11032@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10103011504470.31654-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >What exact functions don't exist?
>
> If you compile with -O0, you also disable inlining, which cause tons of
> link errors for all inline functions. The lowest optimisation level you
> can use is -O1

And I thought it might be as simple as a funny varargs call again :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

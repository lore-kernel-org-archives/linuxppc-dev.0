Date: Tue, 14 Aug 2001 07:18:31 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Occasional crash reports
In-Reply-To: <20010814094529.3E40EDBA11@atlas.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010814071619.95124A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 14 Aug 2001, Iain Sandoe wrote:

> > I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
> > are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
> > rather easily with regular programs, given a day or two.
>
> Can you point at which program reliably crashes beige/G3?

It's usually rsync.

> that's what I use as my dev/build machine and it seems to be stable (2.4.x)
> except under the following circumstance:
>
> If I boot using the BootX application - at which point something drops a
> bomb which almost always ends up in the network stack and shows up as an
> illegal instruction (usually an FP one).

Ah, yes, we use BootX app here, too.  Version 1.2.2, I think.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

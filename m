Date: Fri, 28 Jul 2000 05:13:16 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
In-Reply-To: <Pine.LNX.4.10.10007261351040.443-100000@cassiopeia.home>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000728050930.2549D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Jul 2000, Geert Uytterhoeven wrote:

> There's indeed a global lock on the console, to prevent multiple accesses to
> the console at once. This solves some problems, one being that some graphics
> hardware crashes when both the CPU and the graphics accelerator touch the video
> RAM at the same time.

Would it be difficult to make the lock per fbdev thing?  If the
CPU/accelerator clash is the only reason for the global lock, we can
certainly remove that for hardware which doesn't have that kind of
problem, can't we?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

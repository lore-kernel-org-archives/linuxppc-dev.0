Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <hhk77bv495.fsf@pygar.theorie.physik.uni-muenchen.de>
References: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu>
	 <1065823660.601.0.camel@gaston>
	 <hhk77bv495.fsf@pygar.theorie.physik.uni-muenchen.de>
Content-Type: text/plain
Message-Id: <1065953260.992.11.camel@gaston>
Mime-Version: 1.0
Date: Sun, 12 Oct 2003 12:07:41 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-10-11 at 23:44, Jens Schmalzing wrote:
> Hi,
>
> Benjamin Herrenschmidt writes:
>
> > I just fixed that in my 2.6 and I'll backport to 2.4 soon
>
> I compiled the latest version of that tree in order to get radeonfb
> working on my 17" Powerbook.  A few questions:
>
> 1. The resulting kernel is more than 30MB in size.  Is this normal?

That's not normal, something must be wrong in your kernel build

> 2. The accelerated framebuffer has the right size, but flickers a lot.
>    offb works fine.

What do you mean by "flickers" ? Can you send me the dmesg output ?

> 3. XFree86 from Debian/unstable doesn't work whatever I do, I presume
>    something along the lines of 4.3.99 would be the appropriate
>    version?  If yes, from which source?
>

Yes, you need something more recent like Michel DRI snapshots

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3979E3BB.1B23FE2@wanadoo.fr>
Date: Sat, 22 Jul 2000 20:11:07 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
References: <Pine.LNX.4.10.10007221608490.430-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Thu, 20 Jul 2000, Josh Huber wrote:
>
> You don't have to put your kernel in /usr/src, and you DON'T have to
> symlink /usr/src/linux to it before you build.  The symlinks (on
> broken RedHat derivatives) in /usr/include should point to the kernel
> headers that your libc was built againt, otherwise you risk breaking
> binary compatibility.

This is an argument I have heard several times, but I never understood:
If this risks breaking binary compatibility, then your kernel (compiled
with its own headers, after all) might not be binary compatible with
your glibc. Not nice.

> > On Thu, Jul 20, 2000 at 02:45:56PM +0100, Iain Sandoe wrote:
> > > I guess I *must* have one of those broken derivatives... and it doesn't work
> > > for me without that step...  Admittedly, this is mostly an issue between
> > > 2.2.xx and 2.4.0 - but I do have to remember to change it back between
> > > whiles... a better way would be ?
> >
> > Well...hmm, what doesn't work?  You mean you can't build a kernel
> > unless you make /usr/src/linux point to the kernel source you're
> > building?  This is odd, as I haven't done that...ever!  In fact,
> > there's no directories in /usr/src on my machine.
>
> IIRC, there was a time (long before 2.0) that kernel builds did look for
> includes in /usr/include/, so you had to unpack (or symlink) your kernel in
> /usr/src/linux/. Fortunately the include path was changed to put
> root_of_build/include first.

There *are* situations where you need /usr/src/linux to point to your
current kernel sources. This is when you compile modules for the current
kernel, a prominent example being MOL.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

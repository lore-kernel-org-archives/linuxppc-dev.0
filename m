Date: Tue, 28 Sep 1999 13:45:41 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.13 build OOB?; need for some standardization here?
In-Reply-To: <199909281522.KAA04793@lists.linuxppc.org>
Message-ID: <Pine.LNX.3.96L.990928133108.6218A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Sep 1999, Kevin_Hendricks wrote:
> 
> Isn't there any way to do more standardization among the different powerpc
> linux distributions (I know you want to differentiate your product to
> compete but..)
> 
> Right now, we have Debian ppc, Linux PPC, YellowDog Linux, TurboLinux,
> MkLinux DR1, etc all vying for the same user base.
> 
> This is making for the same support nightmare that already exists on x86 and
> something we should really try hard to avoid?
> 
> For example:
> 
> Look at the proliferation of kernels and versions of glibc "out-there":
> 
> kernels:
>    - 2.2.6 with and without usb support
>    - 2.2.6 with 1.1 and 1.1.6 usb versions
>    - 2.2.10 with either the old usb (1.1. vs 1.1.6) or the new usb, 
>    - 2.2.12 with Linus usb version
>    - all of the above with and without mac-on-linux support
>    - all of the above, with and without Anthony's Rage 128 XF68_FBDev driver

I don't think this has anything to do with distributions. People can install
whatever version of whatever software they want, regardless of their initial
distribution.

> This is literally a nightmare for tracking down bug reports of keycode
> problems in the jdk, video driver problems, etc.

True... One solution would be to reply to bug reports with "reproduce it in
kernel.org's 2.2.12 and we'll look at it." All of the kernel stuff you
mentioned is just part of kernel development, and I don't see how that can be
stopped.

> If on top of this we add glibc 2.1.2 vs glibc 2.1.1 (change in the semaphore
> definitions make them binary incompatible when trying to start up the jdk
> from a c app). (Not to mention the people stuck at glibc 1.99 under MkLinux
> waiting for DR1 to be official).

Pick a target. It should probably be the newest stable release of stuff, ie
kernel.org 2.2.12, glibc 2.1.2, XFree86 3.3.5.

I don't think anyone's worrying much about glibc 1.99 any more...

> Then there is the whole question of where to get your kernel source from?
> You can't seem to use the official kernel source trees for even the *stable*
> relases of 2.2.X.
> 
> Is there any chance 2.2.13 will actually build out of the box on PPC without
> having to add Paul's patches and/or getting it via rsync from Paul's tree.
> Maybe so this time since I noticed Paul's name under Alan Cox's pre-patch
> list of contributors.
> 
> Shouldn't the official *stable* kernel tree always build-out-of-the-box on
> each supported platform?  If so, why isn't this happening in general? 

That would be nice. Unfortunately, x86 people can't exactly test their changes
on PPC, and so more than once the "stable" branch doesn't work here. There
have been conversations about it.

> To more unify this, should we have our own clone of Alan Cox to make
> "semi-official" updates to the "official" stable tree to make things more
> official for ppc.  
> 
> Is this a role for Paul?  (it is the role that Paul has filled for a very
> long time now, maybe it should be "official").  If so, then publize that
> being the one "true" source for "official" ppc kernel trees.
> 
> The lack of standards for Linux is driving the Blackdown x86 JDK porting
> crazy.   Differnt default ulimits for thread stacks between SuSe, RedHat,
> and Debian, differnt glibc's, different versions of libraries, different
> install locations, etc.  
> 
> Up until now, the ppc camp has been pretty immune to all of this.  But now,
> the number of versions of things seems to be growing fast and I fear for the
> worst.  
> 
> Our user base is simply too small to keep that many different distributions
> around.  If we want, commercial software to be ported to LinuxPPC, we really
> need to have a unified user base.

Again, I don't think it has much to do with the distributions. TurboLinux and
early MkLinux (both with glibc 1.99) are very small. MkLinux w/ glibc2 is
limited to the x100 PowerMac users for the most part. Debian is pretty small
because of its installation procedure. I hope LinuxPPC R4 people have upgraded
by now, and LinuxPPC 1999 and YDL 1.1 are pretty damn close. I really don't
think there's that much of a division (aside from very small slices of the pie
chart here and there).

Summary: pick target versions of the packages you're worried about. Someone
else pointed out that Unix software vendors pick a few Unices to develop for.
Since you have finite resources (like commercial vendors), you should do the
same. I think you'll find that you can group a very large percentage of the
Linux/PPC userbase under the glibc 2.1.2 flag.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

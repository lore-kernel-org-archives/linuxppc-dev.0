Message-Id: <199909281810.NAA06999@lists.linuxppc.org>
Date: Tue, 28 Sep 1999 14:08:13 -0400 (EDT)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: 2.2.13 build OOB?; need for some standardization here?
To: khendricks@admin.ivey.uwo.ca, hollis+@andrew.cmu.edu
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>I don't think this has anything to do with distributions. People can install
>whatever version of whatever software they want, regardless of their initial
>distribution.

But Linux PPC and YellowDog linux ship with different kernel versions and 
different usb style support do they not.  Then there is the glibc stuff.  Both 
shipped with glibc 2.1.1 (versions) but the latest LinuxPPC uses (or has) glibc 
2.1.2 (which because of incompatibilities is a nightmare for jdk  using native 
threads).

>True... One solution would be to reply to bug reports with "reproduce it in
>kernel.org's 2.2.12 and we'll look at it." All of the kernel stuff you
>mentioned is just part of kernel development, and I don't see how that can be
>stopped.

I disagree.  I really think it would help to have one clearing house for the 
kernel source tree with all of the latest patches installed so that there are 
not awhole bunch of different incompatible versions flying around (the usb stuff 
for instance). 

I think we should either fix the way Linus and company decides when to release a 
stable version, or get our own "Alan Cox" to act as shepard over our own stable 
"ppc" kernel tree and make that person "official".

>Pick a target. It should probably be the newest stable release of stuff, ie
>kernel.org 2.2.12, glibc 2.1.2, XFree86 3.3.5.

Yes, that is what I have done.  Although I chose glibc 2.1.1 until the other 
distributions start shipping glibc 2.1.2.

But this just illustrates my point.  Everytime you force someone to support only 
a set subset of packages, you fragment the Linux/PPC user base even further.  
Since our base is so small to begin with, any fragmentation will have a very big 
impact. 

>I don't think anyone's worrying much about glibc 1.99 any more...

I do for my 8100 machine hanging around still running MkLinux DR3

>> Then there is the whole question of where to get your kernel source from?
>> You can't seem to use the official kernel source trees for even the *stable*
>> relases of 2.2.X.
>> 
>> Is there any chance 2.2.13 will actually build out of the box on PPC without
>> having to add Paul's patches and/or getting it via rsync from Paul's tree.
>> Maybe so this time since I noticed Paul's name under Alan Cox's pre-patch
>> list of contributors.
>> 
>> Shouldn't the official *stable* kernel tree always build-out-of-the-box on
>> each supported platform?  If so, why isn't this happening in general? 
>
>That would be nice. Unfortunately, x86 people can't exactly test their changes
>on PPC, and so more than once the "stable" branch doesn't work here. There
>have been conversations about it.
>

>Again, I don't think it has much to do with the distributions. TurboLinux and
>early MkLinux (both with glibc 1.99) are very small. MkLinux w/ glibc2 is
>limited to the x100 PowerMac users for the most part. Debian is pretty small
>because of its installation procedure. I hope LinuxPPC R4 people have upgraded
>by now, and LinuxPPC 1999 and YDL 1.1 are pretty damn close. I really don't
>think there's that much of a division (aside from very small slices of the pie
>chart here and there).
>
>Summary: pick target versions of the packages you're worried about. Someone
>else pointed out that Unix software vendors pick a few Unices to develop for.
>Since you have finite resources (like commercial vendors), you should do the
>same. I think you'll find that you can group a very large percentage of the
>Linux/PPC userbase under the glibc 2.1.2 flag.

And if everyone does that, we will just fragment things even further.  That is 
my whole point.  Before we diverge even farther, lets figure out someway to 
prevent the kind of support problems that plague x86 with all its versions / 
libraries / glibcs/ etc.

By the way, (my case in point) I don't think glibc 2.1.2 is that prevalent out 
there.  It only just shipped with Linux PPC Q3, Champion server 1.1 does not 
install it (which makes my point clearer I hope) and the other distributions 
afaik are shipping one version of glibc 2.1.1 or another.

So do I build for glibc 2.1.2, glibc 2.1.1, only one kernel version, only one 
distribution, what?  

That is what I think we *all* should avoid if possible.

My 2 cents.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <199909281522.KAA04793@lists.linuxppc.org>
Date: Tue, 28 Sep 1999 11:20:20 -0400 (EDT)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: 2.2.13 build OOB?; need for some standardization here?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I don't want to start a fight here but...

Isn't there any way to do more standardization among the different powerpc linux 
distributions (I know you want to differentiate your product to compete but..)

Right now, we have Debian ppc, Linux PPC, YellowDog Linux, TurboLinux, MkLinux 
DR1, etc all vying for the same user base.

This is making for the same support nightmare that already exists on x86 and 
something we should really try hard to avoid?

For example:

Look at the proliferation of kernels and versions of glibc "out-there":

kernels:
   - 2.2.6 with and without usb support
   - 2.2.6 with 1.1 and 1.1.6 usb versions
   - 2.2.10 with either the old usb (1.1. vs 1.1.6) or the new usb, 
   - 2.2.12 with Linus usb version
   - all of the above with and without mac-on-linux support
   - all of the above, with and without Anthony's Rage 128 XF68_FBDev driver
   
This is literally a nightmare for tracking down bug reports of keycode problems 
in the jdk, video driver problems, etc.

If on top of this we add glibc 2.1.2 vs glibc 2.1.1 (change in the semaphore 
definitions make them binary incompatible when trying to start up the jdk from a 
c app). (Not to mention the people stuck at glibc 1.99 under MkLinux waiting for 
DR1 to be official).


Then there is the whole question of where to get your kernel source from?  You 
can't seem to use the official kernel source trees for even the *stable* relases 
of 2.2.X.

Is there any chance 2.2.13 will actually build out of the box on PPC without 
having to add Paul's patches and/or getting it via rsync from Paul's tree.  
Maybe so this time since I noticed Paul's name under Alan Cox's pre-patch list 
of contributors.

Shouldn't the official *stable* kernel tree always build-out-of-the-box on each 
supported platform?  If so, why isn't this happening in general? 

To more unify this, should we have our own clone of Alan Cox to make 
"semi-official" updates to the "official" stable tree to make things more 
official for ppc.  

Is this a role for Paul?  (it is the role that Paul has filled for a very long 
time now, maybe it should be "official").  If so, then publize that being the 
one "true" source for "official" ppc kernel trees.

The lack of standards for Linux is driving the Blackdown x86 JDK porting crazy. 
Differnt default ulimits for thread stacks between SuSe, RedHat, and Debian, 
differnt glibc's, different versions of libraries, different install locations, 
etc.  

Up until now, the ppc camp has been pretty immune to all of this.  But now, the 
number of versions of things seems to be growing fast and I fear for the worst.  

Our user base is simply too small to keep that many different distributions 
around.  If we want, commercial software to be ported to LinuxPPC, we really 
need to have a unified user base.

Ideas here?

Comments?

Am I simply worrying too much?

Thanks,

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA   
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

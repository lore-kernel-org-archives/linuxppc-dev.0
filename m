Message-ID: <19990921193653.14861.rocketmail@web125.yahoomail.com>
Date: Tue, 21 Sep 1999 12:36:53 -0700 (PDT)
From: David Hay <hay_dave@yahoo.com>
Reply-To: hay@colorado.edu
Subject: Re: USB driver not detecting mouse? (lots of detail)
To: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Cc: linuxdev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got the 2.3 USB code from cvs.on.openprojects.net.  I had to update it a
bit to include the 2.2 spinlock.h since it seems to have moved in the 2.3
kernel.  If I think of it, I'll try to make some patches once I get home...

Where are these patches you speak of?  From reading the docs in the USB
driver, these patches have made it into the USB tree...or are there non-USB
patches that need to be applied?

David

--- Ira K Weiny <iweiny@falcon.csc.calpoly.edu> wrote:
> I get similar results with the 2.2 kernel.  Have you tried Paul's patches
> for
> the USB code?  Or I should ask where you got the 2.3 USB code.  I could not
> get
> the 2.3 code to compile with the 2.2 kernel.  But I have the cvs 2.3 which
> I
> know is like bleeding edge and I am sure the directions on the USB-HowTo
> don't
> take that into account.  I get tons of include file missing and symbols
> errors...
> 
> So I though I would compile it against the 2.3 kernel and see if I can run
> that.  Of course now I have to get the 2.3 kernel to actually run!!!
> 
> Anyway Paul has patches to the 2.3 USB which take into acount endianes
> issues
> which LinuxPPC needs.
> 
> I can look up the web page if you want for the patches.  Alternativly the
> 2.3
> cvs source has the endianess issues in the code and no need to patch, which
> I
> for one can never get to work.  ;-(
> 
> Good luck.  If I get anything working I will let you know.
> Ira Weiny
> 
> > 
> > I have a Kensington USB Mouse-In-A-Box Scroll mouse which works fine
> under
> > MacOS, so I know there's nothing wrong with the mouse or the Entegra
> 4-Port
> > USB card it's connected to.  I have a Power Tower Pro 225 (if that makes
> a
> > difference)
> 
> ...
> 
> > 
> > Sep 20 18:20:57 dhay kernel:       bEndpointAddress    =   81 (in) 
> > Sep 20 18:20:57 dhay kernel:       bmAttributes        =   03 (Interrupt)
> 
> > Sep 20 18:20:57 dhay kernel:       wMaxPacketSize      = 0001 
> > Sep 20 18:20:57 dhay kernel:       bInterval           =   ff 
> > Sep 20 18:20:57 dhay kernel: ohci-control thread sleeping
> > 
> 

===
------------------------------------------------------------
 David Hay                                     \|/ ____ \|/
 hay@colorado.edu                              ~@-/ oO \-@~
 http://home.earthlink.net/~dhay/              /_( \__/ )_\
 ~ Live well ~ Laugh often ~ Love much ~          \__U_/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

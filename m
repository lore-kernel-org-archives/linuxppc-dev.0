From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909211811.LAA28416@falcon.csc.calpoly.edu>
Subject: Re: USB driver not detecting mouse? (lots of detail)
To: hay@colorado.edu
Date: Tue, 21 Sep 1999 11:11:47 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org (linuxdev)
In-Reply-To: <19990921003754.25514.rocketmail@web125.yahoomail.com> from "David Hay" at Sep 20, 99 05:37:54 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I get similar results with the 2.2 kernel.  Have you tried Paul's patches for
the USB code?  Or I should ask where you got the 2.3 USB code.  I could not get
the 2.3 code to compile with the 2.2 kernel.  But I have the cvs 2.3 which I
know is like bleeding edge and I am sure the directions on the USB-HowTo don't
take that into account.  I get tons of include file missing and symbols
errors...

So I though I would compile it against the 2.3 kernel and see if I can run
that.  Of course now I have to get the 2.3 kernel to actually run!!!

Anyway Paul has patches to the 2.3 USB which take into acount endianes issues
which LinuxPPC needs.

I can look up the web page if you want for the patches.  Alternativly the 2.3
cvs source has the endianess issues in the code and no need to patch, which I
for one can never get to work.  ;-(

Good luck.  If I get anything working I will let you know.
Ira Weiny

> 
> I have a Kensington USB Mouse-In-A-Box Scroll mouse which works fine under
> MacOS, so I know there's nothing wrong with the mouse or the Entegra 4-Port
> USB card it's connected to.  I have a Power Tower Pro 225 (if that makes a
> difference)

...

> 
> Sep 20 18:20:57 dhay kernel:       bEndpointAddress    =   81 (in) 
> Sep 20 18:20:57 dhay kernel:       bmAttributes        =   03 (Interrupt) 
> Sep 20 18:20:57 dhay kernel:       wMaxPacketSize      = 0001 
> Sep 20 18:20:57 dhay kernel:       bInterval           =   ff 
> Sep 20 18:20:57 dhay kernel: ohci-control thread sleeping
> 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

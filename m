From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909012323.QAA05335@falcon.csc.calpoly.edu>
Subject: Re: 2.2.6-15apmac vs. 2.2.12 USB support
To: puetzk@iastate.edu
Date: Wed, 1 Sep 1999 16:23:23 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990901163924.B1068@puetz.penguinpowered.com> from "Kevin Puetz" at Sep 1, 99 04:39:24 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> On Wed, 01 Sep 1999 12:16:15 Ira Weiny wrote:
> > 
> > I have been running with a USB card/3-button mouse on my PowerMac 8500 
> > 2.2.6-15apmac kernel since getting my 1999 release a month ago.  I have 
> > been trying to upgrade my kernel to 2.2.10 & now 2.2.12.  I have found 
> > that if I configure USB support on these new kernels they will not 
> > boot. (see my previous posts for OF 2.2.10 booting problems)
> > 
> > Does anyone know what the 2.2.6-15apmac settings are for USB support?  
> > Do the new kernels not have the same support, do I need a patch for the 
> > new kernels?
> > 
> > I have tried OHCI, UHCI, OHCI_HUB, & DEBUG in various combinations but 
> > have been unsuccessfull.
> > 


> 
> I have the same problem with a Belkin BusPort in a beige G3.
> 
> It works fine with the stock R5 kernels, and I once (back in R4) compiled a 
> kernel myself with support. But that was uusbd, and I assume the R5 kernel 
> is the new USB stack.

Sort of, the stock 2.2.6 kernel which comes with the 1999 release is uusbd but
the current (>2.2.9?) usb is now under ./drivers/usb.  Furthermore the code
is quite different from the ./uusbd in the 2.2.6 kernel.  It is this difference
which is confusing me.  One file in particular [usb-pci.h] would seem nessasary
for supporting my particular configuration.  However, it is gone and I don't
know if that functionality made it to the current source.  Hence, "do I need a
patch for the new kernel?"  Or maybe PCI based USB is just not supported yet.
I always wanted to write a device driver...  ;-)

> 
> Could someone who has built usb-capable kernels from recent sources put 
> their .config up somewhere?

I suppose I should have posted this question to the developers list and not the
user list.  Sorry, I don't know if compiling a kernel is a developer thing or a
user thing.  It seems these days it is a user thing although I am one user who
can't seem to figure it out.  ;-(  [once again appologizing for my stupidity]

Thanks
Ira Weiny


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

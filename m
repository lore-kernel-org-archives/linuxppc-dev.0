Return-Path: <jmarc007@yahoo.com>
Received: from n69.bullet.mail.sp1.yahoo.com (n69.bullet.mail.sp1.yahoo.com
	[98.136.44.41]) by ozlabs.org (Postfix) with SMTP id 6A7AFDE26A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 18:36:09 +1000 (EST)
Date: Thu, 17 Apr 2008 01:36:08 -0700 (PDT)
From: John Marc <jmarc007@yahoo.com>
Subject: Re: USB on MPC8641D
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0C6DE62B-F58F-4E61-B7AC-56EC1D1DCAE7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <624875.78682.qm@web46013.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi 
I Have the kernel patches , but no one for the USB.
The changes for the USB are integrated in the Kernel.
I am currently looking into the linux BSP for usb
changes , but unfortunately don't find any major
chages. 

MPC8641 board have one EHCI controller and 3 OHCI
conroller.

As I am also new to USB , it would be great help, if
someone give me any idea about the changes in new
MPC8641 BSP ?

Does freescale fix the PCI Express issue , that makes
USB works.  

I have lots of hope with this forum :-)


With Regards
John 


--- Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Apr 16, 2008, at 1:48 PM, John Marc wrote:
> > Hi Everybody,
> > I find this forum very much useful for the people
> who are working  
> > with powerpc's , and i am the one of them.Actually
> one more thing  
> > that make me to join this forum is my interest
> towards the Freescale  
> > MPC8641d board :-). I found that Freescale
> recently uploaded the  
> > linux BSP for MPC8641D board. One of the thing new
> in this BSP is  
> > USB driver.
> >
> > At Ozlabs I found various patches for MPC8641D
> board,Most of then  
> > are regarding the PCI Express fixes, Some patches
> of ULI1575 chip,  
> > but my main concern is USB.
> >
> > Can amyone help me out to find , what are the
> changes that freescale  
> > does for the USB drivers. I tried to search a lot
> for USB patch, but  
> > my bad luck , i don't find anything.
> >
> > It would be a great help if anyone help me out to
> find what are the  
> > changes that freescale does for USB driver.
> 
> There shouldn't be any, but if you have a BSP from
> Freescale you  
> should have patches to that kernel as well.
> 
> We should be using the stock USB driver for the ULI
> chipset.  (I  
> forget if its ehci/ohci/uchi).
> 
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ

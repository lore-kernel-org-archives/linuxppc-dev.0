Message-ID: <XFMail.990513053536.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.BSI.3.96.990512182248.24792A-100000@usr08.primenet.com>
Date: Thu, 13 May 1999 05:35:36 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Jeff Rugen <jrugen@primenet.com>
Subject: RE: Motorola Powerstack Parallel Port
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 13-May-99 Jeff Rugen wrote:
> 
> Ok, according to the book that came with my Motorola PowerStack, I have a
> parallel port that is compatible with IEEE standard 1284, including the
> Extended Capability Port (ECP) and Enhanced Parallel Port (EPP).  However,
> the driver (parport_pc) doesn't recognize it as ECP and EPP, and says its
> only SPP.  I haven't played around the parallel port much, so I figured I'd
> ask first, to see if anyone else had looked into this before.  Does the
> kernel need to do some sort of initialization before the parallel port is
> recognized as such?   (I do have a B&W quickcam plugged into the port now,
> but I don't think that should affect the detection).
> 

It might - those devices do funky things to the port even though they are
supposed to be invisible unless being accessed.

> I have one of the old 100MHz 604 machines.  I'm trying to get the quickcam
> drivers working with the 2.2.x/2.3.x kernel (I had one of the drivers
> working with the 2.0.x kernel, but I don't know if it was in EPP or SPP
> mode).
> 
> Any help, pointers, or advice on this topic would be much appreciated.
> If you know what specific chip is used to implement the parallel
> port, I can look around for a data book on it as well.  Thanks for any help.
>

The parallel port, along with most of the other devices in the system, are
implemented in the PCI-bridge chip (82473 IIRC).
 

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

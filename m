Message-ID: <XFMail.990122110718.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.3.96.990122011837.2237A-100000@persephone.cs.nmt.edu>
Date: Fri, 22 Jan 1999 11:07:18 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Cc: Michael Meissner <meissner@cygnus.com>
Cc: Michael Meissner <meissner@cygnus.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linuxppc-dev@lists.linuxppc.org, Dan Malek <dmalek@jlc.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 22-Jan-99 Cort Dougan wrote:
> You're right.
> 
> }What about the fixes for the PS/2 mouse?  These are not large, but
> }significant for systems that need to intialize the mouse from scratch.
> 
> I'll take another look at the patch.

Thanks.  The important files [for this one] are:
  drivers/char/pc_keyb.[ch]
  drivers/char/Config.in

Also the changes I made to the PPC configure files are useful and can be
separated from the boot changes.


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

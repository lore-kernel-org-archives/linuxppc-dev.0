Date: Wed, 5 May 1999 10:29:25 +1000
Message-Id: <199905050029.KAA04901@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ranga@CSUA.Berkeley.EDU
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199905042220.PAA17423@soda.CSUA.Berkeley.EDU> (message from
	Sriranga Veeraraghavan on Tue, 04 May 1999 15:20:37 -0700)
Subject: Re: USB under LinuxPPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199905042220.PAA17423@soda.CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU> wrote:

> I have been trying to compile USB support into the 2.2.5 kernel on
> LinuxPPC using the uusb driver.
> 
> On my LinuxPPC machine I keep getting errors that the struct s_snode
> has no element named lock. I checked in usb-slist.h and this struct's
> definition does not have an element named lock, nevertheless it is
> referenced throughout the usb driver code. 

You must be compiling an SMP kernel.  The uusbd stuff doesn't support
SMP yet.  You'll have to compile with CONFIG_SMP=n if you want to use
uusbd.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

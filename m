Message-ID: <37DD3784.F85402CD@jlc.net>
Date: Mon, 13 Sep 1999 13:42:28 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Richard Hendricks <ra6353@email.sps.mot.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC with BDM
References: <37DC9380.D0A6BA3F@ctam.com.au> <37DD0BE1.5DA876F@email.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
> 
> The BDM runs into problems when the underlying operating system uses the
> MMUs to implement a page table.


That's the biggest one.  Also, all of the BDMs I have used make
assumptions about the target environment.  Things like some
monitor support and debug register settings also get in the way.

Motorola's mpc8bug is the only BDM I have found that would let
me download and run....no debug mind you, just get out of the way
and run the code.  You have to make sure all of the debug is
disbled before you let it go.


> > I have been using the BDM to download kernels and running them from RAM
> > (stepping through the code, etc).  Could this be the cause of the
> > strange behaviour I've seen on the ADS boards ?


Yep.  You can only disable all debugging and let it go.


> ...  Unfortunately it will
> > only run on a Windows machine due to the wigglers.dll which is
> > required.



I am working with a company right now developing some embedded
tools hosted on a Linux/PPC (possibly Linux/x86) that includes
a BDM interface.  More interesting though is the Cygnus InSight and
GDB server I have running for application development.  People
forget that it is the application that makes the difference.
Porting and compiling a kernel these days is not a challenge like
getting a real embedded product to market.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <37DD0BE1.5DA876F@email.sps.mot.com>
Date: Mon, 13 Sep 1999 09:36:17 -0500
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC with BDM
References: <37DC9380.D0A6BA3F@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The BDM runs into problems when the underlying operating system uses the
MMUs to implement a page table.  Since the BDM doesn't understand page
tables, when it stops the core it assumes the PC is pointing into
physical memory.  This makes debugging the kernel difficult using BDM. 
Using the BDM inherently doesn't change any registers, but MPC8bug may
initialize some registers you don't want it to.

Brendan Simon wrote:
> 
> Dan mentioned (in another email) that mpcbug can cause problems when
> running linux.  I take it this is a generic BDM problem.  Is this true
> ?  In theory it shouldn't matter should it, as long as the debugger
> leaves the core in the same condition just before it enters debug mode.
> 
> I have been using the BDM to download kernels and running them from RAM
> (stepping through the code, etc).  Could this be the cause of the
> strange behaviour I've seen on the ADS boards ?
> 
> Should I stear clear of the BDM ?  I would prefer to use it as it allows
> alot of low level debugging and control.
> 
> Brendan Simon.
> 
> BTW. I have been using a beta version of GDB with support for the
> Macraigor Wiggler.  I got it from Scott Howard.  Unfortunately it will
> only run on a Windows machine due to the wigglers.dll which is
> required.  If anyones interested in this then there is more information
> on http://www.objsw.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

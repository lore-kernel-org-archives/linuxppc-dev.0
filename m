Message-ID: <19990522193719.15424@ibrium.se>
Date: Sat, 22 May 1999 19:37:19 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org, marsmail@globegate.utm.edu
Subject: Re: Mac-on-Linux
References: <19990522020440.49547@ibrium.se> <Pine.LNX.3.96.990521213127.19285C-100000@globegate.utm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990521213127.19285C-100000@globegate.utm.edu>; from David A. Gatwood on Fri, May 21, 1999 at 09:35:21PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 21, 1999 at 09:35:21PM -0500, David A. Gatwood wrote:
> 
> 
> Quick question: what is the nature of the kernel support for mac-on-linux? 
> Some folks in the MkLinux camp have been discussing writing equivalent
> 2.0.xx kernel code that works through mach.  I know that it will likely
> need to be able to map the ROMs into user space.  I also suspect that
> handling code (which could be very messy, but we'll cross that bridge when
> we get to it) and possibly the memory management code.  Beyond that, what
> other hurdles are there?

The Mac-on-Linux kernel support code has in principle the following 
tasks:

  - Emulate privileged instructions.
  - Handle the MMU (maps ROM, RAM etc.)

The implementation is primarily based upon hooks in the
low-level exception handlers. Besides this, the interaction
with the kernel has been kept at a minimum.

I believe the exception hooks must be put into the
mach kernel - possibly it is easiest to put all code 
there.

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470   
----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

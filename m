Date: Tue, 8 Jun 1999 20:16:14 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Q: control is a C&T 65550?
Message-ID: <19990608201614.A15209@drow.res.cmu.edu>
References: <19990608095844.A5496@drow.res.cmu.edu> <Pine.LNX.4.10.9906081600260.20992-100000@mercator.cs.kuleuven.ac.be> <19990608101236.A5738@drow.res.cmu.edu> <199906082354.JAA05316@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199906082354.JAA05316@tango.anu.edu.au>; from Paul Mackerras on Wed, Jun 09, 1999 at 09:54:18AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 09, 1999 at 09:54:18AM +1000, Paul Mackerras wrote:
> Daniel Jacobowitz <drow@false.org> wrote:
> 
> > That's one of those if-i-had-more-time things - and more specifically,
> > if I knew how to dump video regs under macos.  Is it trivial?
> 
> This is where I use xmon.  There is a macos version at (I think)
> ftp://ftp.linuxppc.org/users/paulus/misc/xmon.bin.  From memory, the
> control registers are at 0x90010000 and the RADACAL (ramdac/cursor
> chip) registers are at 0xf301b000.
> 
> The other thing to do is to browse through the darwin sources from
> apple and see if they have a control driver somewhere.
> 
> IIRC, the hardware cursor uses some extra bytes on each scan line and
> some registers in the RADACAL.

Ahah, xmon might be quite useful here.  Also, were I to browse Darwin,
would I be able to use that information?  Have those licence problems
ever been straightened out?


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

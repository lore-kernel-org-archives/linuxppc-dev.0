Date: Tue, 8 Jun 1999 10:12:36 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Q: control is a C&T 65550?
Message-ID: <19990608101236.A5738@drow.res.cmu.edu>
References: <19990608095844.A5496@drow.res.cmu.edu> <Pine.LNX.4.10.9906081600260.20992-100000@mercator.cs.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9906081600260.20992-100000@mercator.cs.kuleuven.ac.be>; from Geert Uytterhoeven on Tue, Jun 08, 1999 at 04:00:48PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 08, 1999 at 04:00:48PM +0200, Geert Uytterhoeven wrote:
> On Tue, 8 Jun 1999, Daniel Jacobowitz wrote:
> > On Tue, Jun 08, 1999 at 07:51:39AM -0400, Jason Y. Sproul wrote:
> > > Is it correct that the /chaos/control chip is essentially a Chips &
> > > Technologies 65550? If so, does anyone have the variances from the 65550
> > > datasheet, and if not, what the heck is it? :^)
> > 
> > It's my understanding that it's not.  No one has any documentation on
> > it to my knowledge... I'd love to add hardware cursor support, which
> > I'm fairly sure it has, to controlfb.  But I can't do it without some
> > sort of reference.
> 
> Move the cursor under MacOS and see which registers or video memory addresses
> change?

That's one of those if-i-had-more-time things - and more specifically,
if I knew how to dump video regs under macos.  Is it trivial?

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

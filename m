Date: Sat, 2 Jan 1999 20:14:32 -0500
From: Daniel Jacobowitz <drow@false.org>
To: satadru pramanik <satadru@umich.edu>
Cc: Brad Midgley <brad@pht.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Message-ID: <19990102201432.A736@drow.res.cmu.edu>
References: <Pine.LNX.3.96LJ1.1b7.990102121137.439B-100000@cricket> <Pine.SOL.4.05.9901021800540.29365-100000@asteroids.rs.itd.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.4.05.9901021800540.29365-100000@asteroids.rs.itd.umich.edu>; from satadru pramanik on Sat, Jan 02, 1999 at 06:04:01PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 02, 1999 at 06:04:01PM -0500, satadru pramanik wrote:
> Please let me know!!! And if this _does- fix the problem, it should go to
> linus asap, before 2.2 gets finalized.  This certainly is a problem for
> me, and I can't imagine seeing a 2.2 final kernel that hangs on serious
> scsi activity. ( it crashes my web server every ten minutes.)
> 
> 
> On Sat, 2 Jan 1999, Brad Midgley wrote:
> 
> 
> paul,
> 
> what was the result of testing this patch? i see it isn't present at vger.
> but does it make scsi activity safer? does it need more testing? should i
> test it as-is?
> 
> dan, have you figured out a setup to burn cd's without panics?


I am not at my machine for another week, but judging from what I have
heard - the patch does make it safer, is certainly a good idea to
apply, and yet still does not resolve the issue.  I need to find out
how it affects my machine - expect this as soon as I can.

Meanwhile, Satadru, I suggest you invest in an internal drive - or try
using all your devices on the same scsi controller, which I have heard
might help.


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|     CMU, CS class of 2002      |
|   Debian GNU/Linux Developer    __   Part-Time Systems Programmer  |
|         dan@debian.org         |  |        drow@cs.cmu.edu         |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

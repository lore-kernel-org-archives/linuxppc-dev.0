Date: Thu, 18 Mar 1999 18:18:02 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SCSI crashes with vger
In-Reply-To: <19990319000756.005553@mail.mipsys.com>
Message-ID: <Pine.LNX.4.05.9903181816420.8817-100000@p05-10.hartford.dialin.ntplx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Mar 1999, Benjamin Herrenschmidt wrote:

> On Thu, Mar 18, 1999, Tom Rini <tmrini@ntplx.net> wrote:
> 
> >Erg <paranoid worry>. In 2.2.2 there was a "scsi fix" which seems to have
> >fixed the problem that some people (myself, Dan J) had when trying to do
> >things like burn a CD on the ext chain or use both chains at once.  Now
> >it's working well enough for me to do a silly thing like a raid0 /usr :)
> >Hope this isn't related.. </paranoid worry>
> 
> Do you still have the patch around so that i can revert it and see what
> happen ? I'm really not familiar enough with linux to track this none. I
> tried, but got deep inside the scsi subsystem, looks like it's crashing
> when completing the request with a program check exception (which can
> mean a lot of things, I still have to find out how to display SRR1 from xmon).

The patch that "fixed" things before was incorrect and added in some
cli()s i think.  The actual fix shouldn't be too hard to yank out of
patch-2.2.2, on any of the kernel.org mirrors.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

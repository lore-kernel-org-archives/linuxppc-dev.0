Date: Fri, 19 Mar 1999 15:32:03 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SCSI crashes with vger
In-Reply-To: <19990319181231.022598@mail.mipsys.com>
Message-ID: <Pine.LNX.4.05.9903191529140.14954-100000@p05-10.hartford.dialin.ntplx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Mar 1999, Benjamin Herrenschmidt wrote:

> On Thu, Mar 18, 1999, Tom Rini <tmrini@ntplx.net> wrote:
> 
> >The patch that "fixed" things before was incorrect and added in some
> >cli()s i think.  The actual fix shouldn't be too hard to yank out of
> >patch-2.2.2, on any of the kernel.org mirrors.
> 
> I didn't find any patch in the scsi code that looks like what you
> describe in 2.2.2 and 2.2.3 patches on kernel.org, but the fix may have
> been elsewhere...

Er, I guess I wasn't too clear.  The wrong patch looked nothing like the
right patch. :)  The "right" patch was the generic scsi fix listed in the
2.2.2 rel notes, not sure what files tho.  However in skimming the 2.2.2
patch I saw some changes to linux/drivers/scsi/ncr53c8xx.c.  reversing
this had no effect I take it? (didn't look at the full context of where
the diff went, might not effect us at all..)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

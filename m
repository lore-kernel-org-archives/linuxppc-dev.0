In-Reply-To: <Pine.LNX.4.05.9903181816420.8817-100000@p05-10.hartford.dialin.ntplx.com>
Date: Fri, 19 Mar 1999 18:12:31 +0100
To: Tom Rini <tmrini@ntplx.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: SCSI crashes with vger
Message-Id: <19990319181231.022598@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 18, 1999, Tom Rini <tmrini@ntplx.net> wrote:

>The patch that "fixed" things before was incorrect and added in some
>cli()s i think.  The actual fix shouldn't be too hard to yank out of
>patch-2.2.2, on any of the kernel.org mirrors.

I didn't find any patch in the scsi code that looks like what you
describe in 2.2.2 and 2.2.3 patches on kernel.org, but the fix may have
been elsewhere...

As far as I know, the problem is a page fault in the interrupt handler of
the NCR driver, when completing a request. I'm not familiar enough with
both the scsi subsystem and linux vm to conclude anything from that, but
I'm still trying to figure out what's happening. Some help (directions to
look into) would be welcome, I'll post a more detailed report of what I
found until now later today.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Sat, 27 Jan 2001 16:18:22 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010127161821.A2695@allspice.cs.swarthmore.edu>
References: <20010126122229.B2874@allspice.cs.swarthmore.edu> <19341222051115.6472@smtp.wanadoo.fr> <20010127145758.A26243@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010127145758.A26243@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sat, Jan 27, 2001 at 02:57:58PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 02:57:58PM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> On Sat, Jan 27, 2001 at 12:39:31PM +0100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Do you get the same lockup without the G3 accelerator ?
>
> Good question.  I got the CD-RW and the accelerator at the same time,
> so I actually have no idea.  About six months ago when I made a brief
> attempt to look into this problem, I found another report of the same
> thing, which I don't think mentioned an accelerator.  I'll have to try
> to figure out where I saw that.  In any case, I can swap in the old CPU
> this weekend and see if it works.  I'll report back when I have more
> information.

I just tried this without the G3, and the exact same thing happens.  I
also did "dmesg -n 8" on the console where I tried to run cdrdao, before
burning the CD, but got no additional output.  I'll try this again both
with cdrecord (which had the same failure mode the last time I was
trying to solve this problem) and with syslog logging only to the
console.  If those don't work, I guess the next step is probably to see
if I can see anything over a serial console, and maybe to install
another copy of the OS on the external hard disk and boot from there,
and see if that lets me get more information?

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

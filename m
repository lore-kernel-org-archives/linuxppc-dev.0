Date: Sat, 27 Jan 2001 14:57:58 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010127145758.A26243@allspice.cs.swarthmore.edu>
References: <20010126122229.B2874@allspice.cs.swarthmore.edu> <19341222051115.6472@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19341222051115.6472@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sat, Jan 27, 2001 at 12:39:31PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 12:39:31PM +0100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Do you get the same lockup without the G3 accelerator ?

Good question.  I got the CD-RW and the accelerator at the same time,
so I actually have no idea.  About six months ago when I made a brief
attempt to look into this problem, I found another report of the same
thing, which I don't think mentioned an accelerator.  I'll have to try
to figure out where I saw that.  In any case, I can swap in the old CPU
this weekend and see if it works.  I'll report back when I have more
information.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

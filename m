Message-ID: <37FF8214.EB42C5A4@chpc.utah.edu>
Date: Sat, 09 Oct 1999 11:57:40 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: update on macserial/DMA
References: <Pine.LNX.3.96LJ1.1b7.991005234830.1210A-100000@ofey.inetnebr.com> <37FD998B.3D0E62B0@chpc.utah.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lou Langholtz wrote:

> Takashi Oe wrote:
>
> > Hi,
> >
> > I re-wrote the serial DMA support code today and put the patch against
> > samba/vger linux-2.2.12 source trees (as of tonight) at
> > ftp://ppc.linux.or.jp/pub/users/toe/serial/.
> > I think the patch includes most of macserial patches (Ben's and Lou's
> > are in there, for sure) that I know of. . .
>
> We should probably also clean up the two unneeded buf[64] allocations. These
> would be at lines 1535 and 1572 in Takashi Oe's macserial.c file. They've
> been left over for a few rounds now and I don't see how they're needed for
> anything.

Also, I noticed that while others reported the DMA addition resulted in far
better TCP/IP over PPP performace, I found no such improvement. The difference
seems to be that I've been using the 2.2.12 distribution kernel rather than a
vger kernel and I'll guess that it's the memory management change that accounts
for this. Anyway, I'm going to see if the imporvement will happen now with AC's
2.2.13pre15 kernel with the assumption that the effective memory management
difference is in that. I'm very eager to see the improvements that others have
noted! :-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

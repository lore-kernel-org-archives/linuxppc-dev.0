Message-ID: <37FD998B.3D0E62B0@chpc.utah.edu>
Date: Fri, 08 Oct 1999 01:13:16 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: update on macserial/DMA
References: <Pine.LNX.3.96LJ1.1b7.991005234830.1210A-100000@ofey.inetnebr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:

> Hi,
>
> I re-wrote the serial DMA support code today and put the patch against
> samba/vger linux-2.2.12 source trees (as of tonight) at
> ftp://ppc.linux.or.jp/pub/users/toe/serial/.
> I think the patch includes most of macserial patches (Ben's and Lou's
> are in there, for sure) that I know of. . .

We should probably also clean up the two unneeded buf[64] allocations. These
would be at lines 1535 and 1572 in Takashi Oe's macserial.c file. They've
been left over for a few rounds now and I don't see how they're needed for
anything.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

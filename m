Message-Id: <4.2.1.9.19991007113857.00de0c00@mail.munich.netsurf.de>
Date: Thu, 07 Oct 1999 11:48:22 +0200
To: Takashi Oe <toe@unlserve.unl.edu>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: update on macserial/DMA
Cc: Benjamin Herrenschmidt <bh40@calva.net>, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.991005234830.1210A-100000@ofey.inetne
 br.com>
References: <19990930183542.004164@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 07:33 06.10.99 , Takashi Oe wrote:

>Hi,
>
>I re-wrote the serial DMA support code today and put the patch against
>samba/vger linux-2.2.12 source trees (as of tonight) at
>ftp://ppc.linux.or.jp/pub/users/toe/serial/.
>I think the patch includes most of macserial patches (Ben's and Lou's
>are in there, for sure) that I know of.

Wow, this (well, with slight mods for 2.3.18vger) works like a charm for me 
on my slooow 7200/75. Now heavy disk usage doesn't influence the transfer 
performance anymore and the error rate is extremely low. This patch should 
be added to the kernel sources ASAP IMHO.

Many thanks,
Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

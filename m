From: phandel@cise.ufl.edu
Date: Thu, 7 Oct 1999 11:37:06 -0400 (EDT)
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: update on macserial/DMA
In-Reply-To: <4.2.1.9.19991007113857.00de0c00@mail.munich.netsurf.de>
Message-ID: <Pine.LNX.4.10.9910071135260.2157-100000@dialup-l116.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 7 Oct 1999, Franz Sirl wrote:

> Wow, this (well, with slight mods for 2.3.18vger) works like a charm for me 
> on my slooow 7200/75. Now heavy disk usage doesn't influence the transfer 
> performance anymore and the error rate is extremely low. This patch should 
> be added to the kernel sources ASAP IMHO.

Same here - I used to have to run at a port rate of 56k; now I have either
0 or 1 errors/overruns after hours of surfing/downloading at a port rate
of 230.4k! (Using Paul's rsync 2.2.12)  Thanks a bunch, Takashi!


Thanks,
Peter

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

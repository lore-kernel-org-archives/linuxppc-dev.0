Date: Sat, 6 Feb 1999 16:22:40 +0100 (CET)
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <Pine.LNX.4.02.9901311514590.2341-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.04.9902061615290.537-100000@bogomips.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 31 Jan 1999, Geert Uytterhoeven wrote:

> > As far I know, Geert got it to compile on ppc, but it's not working yet.
> 
> It crashes with a bus error. That is, the unaccelerated version. I
> don't have a Matrox, and I had to disable the ATI code because it
> contains inline ia32 assembler.
> 
> I think the bus error is related to trying to map the frame buffer
> using /dev/mem instead of /dev/fb0.

IMHO it is more likely that the Server tries to access some I/O ports
(probe for ISA-VGA or something like that) without having them mapped.
At least I ran into this problem while playing with 3.9Nz.

  Gerd



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Sun, 31 Jan 1999 15:24:20 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <199901310938.KAA06173@goldbach.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.02.9901311514590.2341-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 31 Jan 1999, Gerd Knorr wrote:
> In lists.linuxppc.dev you write:
> 
> >I apologize for the length, but I don't want to leave anything
> >out that might be critical....
> 
> >Let me open with two quick questions.  A while back on linux-kernel
> >someone said that they had ported X_SVGA with Matrox acceleration
> >to FB, and Geert asked the guy for a copy of the patch.
> 
> Thats me.  The patch is available from
> 	http://www.in-berlin.de/User/kraxel/xfree86/
> 
> >What are the odds that I could get a hold of that, and that it would
> >compile and possibly run under PPC?  Slim to none I bet, but 
> >it would be nice...
> 
> As far I know, Geert got it to compile on ppc, but it's not working yet.

It crashes with a bus error. That is, the unaccelerated version. I don't have a
Matrox, and I had to disable the ATI code because it contains inline ia32
assembler.

I think the bus error is related to trying to map the frame buffer using
/dev/mem instead of /dev/fb0. I know that shouldn't give a bus error, but I saw
a similar thing with my (still experimental) program to get some useful video
out of my S3 Vision968. Last time I tried, it crashed with a bus error when
writing to the VRAM. Unfortunately I can't be 100% sure yet that it's a bug in
recent kernels, since I had to recompile that test program after I migrated to
Debian, which uses glibc-2.1pre.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

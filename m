Date: Tue, 27 Jul 1999 16:42:11 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: Kamran Karimi <karimi@cs.uregina.ca>
cc: Paul Mackerras <paulus@cs.anu.edu.au>, linuxppc-dev@lists.linuxppc.org
Subject: Re: DIPC for PowerPC
In-Reply-To: <Pine.SGI.3.91.990725195009.22777A-100000@MERCURY.CS.UREGINA.CA>
Message-ID: <Pine.BSF.3.96.990727164140.1221R-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 25 Jul 1999, Kamran Karimi wrote:

> 
> Hi Paul,
> 
> On Mon, 26 Jul 1999, Paul Mackerras wrote:
> 
> > I tried it on the weekend.  I had to make a couple of small changes to
> > get the kernel to compile: asm-ppc/ipc.h didn't define DIPC, and PPC
> > systems (at least the vast majority of the systems that Linux will run
> > on) are 32-bit, not 64-bit.  I have appended below the diffs for
> > include/asm-ppc (ipc.h and dipc.h).
> 
>  Thanks. I'll incorporate your changes ASAP. Is there a way to determine 
> at kernel compile time whether the machine is 32 bit or 64 bit?

It's called CONFIG_PPC64 right now I think..

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

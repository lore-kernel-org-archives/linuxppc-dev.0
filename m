Date: Thu, 19 Aug 1999 09:56:30 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Brad Boyer <flar@marcus.pants.nu>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Latest version of CPU emulator] (fwd)
In-Reply-To: <199908181746.KAA03079@marcus.pants.nu>
Message-ID: <Pine.HPX.4.10.9908190921590.27955-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 18 Aug 1999, Brad Boyer wrote:

> 
> Geert Uytterhoeven wrote:
> > Perhaps Gabriel's 486SX emulator can be included as an optimization?
> 
> I doubt it, from what I know of both emulators.  The one that was submitted
> for Wine is protected mode only, and Gabriel's is real mode only.  I
> imagine the ideas and some of the code from Gabriel's emulator could
> be adapted to this use, but it definitely couldn't be used without
> some major changes.  It might be a good place to start, tho.

Actually adding protected mode (segmentation) is not that complex,
but adding paging (like Bochs) would be an enormous task I'm not ready to 
undertake. Adding the FPU is feasible but not a simple job (MMX is easy).

My goal was the smallest possible emulator to interpret BIOS ROM and
that's how it has stayed until now. It is reasonably fast (around 6 MIPS
on a 200 MHz 603e) only because it entirely fits into L1 cache (except
plain 603). I could improve the speed slightly (20-30%), at some cost in
size, at least I believe so.

Still the best thing in my code is how the flags are emulated IMHO.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

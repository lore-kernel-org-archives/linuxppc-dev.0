Date: Mon, 30 Oct 2000 13:18:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: Neil Russell <caret@c-side.com>, David Riley <oscar@the-rileys.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC byte ordering
In-Reply-To: <v04220803b622eb4a1108@[10.0.0.42]>
Message-ID: <Pine.LNX.4.10.10010301315510.413-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 30 Oct 2000, Timothy A. Seufert wrote:
> At 5:24 PM -0700 10/28/00, Neil Russell wrote:
> >It would in theory be possible to have the kernel run big-endian as it is
> >and have certain user programs run little endian by setting the LE bit in
> >the MSR register for the process in question.  The real problem here is
> >that you have to add a *lot* of code to system calls to make this work.
> >There are a few system calls that this would be real difficult, such
> >as ioctl().  I once looked into doing this for the MIPS with SVR4 UNIX.
>
> The other real problem is that Linus Torvalds has already said that
> he will never ever in a million years accept a patch which attempts
> to do such a thing, so you'd have to fork the kernel to do it.
> According to Linus, architectures are either big or little-endian,
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> not both.  A sane position considering the syscall ugliness you
  ^^^^^^^^^
> mention...

Really? Or did he mean: big-endian kernels must not run little-endian binaries
and vice versa.

Note that there exist 3 flavors of MIPS: 32-bit big-endian, 32-bit
little-endian and 64-bit. Linux supports them all. Expect to upgrade the hard
drives on your local Debian mirror soon :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

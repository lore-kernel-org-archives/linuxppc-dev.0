Mime-Version: 1.0
Message-Id: <v04220801b6245b031367@[10.0.0.42]>
In-Reply-To: <Pine.LNX.4.10.10010301315510.413-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10010301315510.413-100000@cassiopeia.home>
Date: Tue, 31 Oct 2000 03:23:01 -0800
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PPC byte ordering
Cc: Neil Russell <caret@c-side.com>, David Riley <oscar@the-rileys.net>,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:18 PM +0100 10/30/00, Geert Uytterhoeven wrote:
>On Mon, 30 Oct 2000, Timothy A. Seufert wrote:
>>  At 5:24 PM -0700 10/28/00, Neil Russell wrote:
>>  >It would in theory be possible to have the kernel run big-endian as it is
>>  >and have certain user programs run little endian by setting the LE bit in
>>  >the MSR register for the process in question.  The real problem here is
>>  >that you have to add a *lot* of code to system calls to make this work.
>>  >There are a few system calls that this would be real difficult, such
>>  >as ioctl().  I once looked into doing this for the MIPS with SVR4 UNIX.
>>
>>  The other real problem is that Linus Torvalds has already said that
>>  he will never ever in a million years accept a patch which attempts
>>  to do such a thing, so you'd have to fork the kernel to do it.
>>  According to Linus, architectures are either big or little-endian,
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>  not both.  A sane position considering the syscall ugliness you
>   ^^^^^^^^^
>>  mention...
>
>Really? Or did he mean: big-endian kernels must not run little-endian binaries
>and vice versa.
>
>Note that there exist 3 flavors of MIPS: 32-bit big-endian, 32-bit
>little-endian and 64-bit. Linux supports them all. Expect to upgrade the hard
>drives on your local Debian mirror soon :-)

You're absolutely correct -- what he doesn't want (at least as I
interpreted the email I'm remembering from a linux-kernel discussion)
is mixing modes.  In other words, the official Linus kernel will
never support mixed LE and BE processes at runtime; you must choose
one or the other at kernel compile time.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

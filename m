Date: Wed, 6 Sep 2000 22:41:09 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: frowand@mvista.com
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: question about 'r2' !!!
In-Reply-To: <39B6A7A5.3EAF964F@mvista.com>
Message-ID: <Pine.LNX.4.10.10009062235520.30076-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > The mind fairly boggles. Anyway, once upon a time, current wasn't kept in
> > a register but in memory. And if r2 won't do, just pick another register
> > and tell the compiler not to touch it. Hope your compiler of choice has
> > such a thing as --fixed-r2 ...
> >
>
> And if you want to use kgdb to debug your kernel, gdb knows that current is r2...

If you're unable to use gcc for building your kernels, chances are there
won't be a gdb around either. I fully expect to see yet another kernel
debugger option in the kernel if that sort of 'build a Linux kernel using
the compiler of your choice' game does catch on. If you can get the kernel
to build without relying on gcc, adding a new remote debug stub should not
pose a major problem.

For the rest of us, let's stick to gcc and friends.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

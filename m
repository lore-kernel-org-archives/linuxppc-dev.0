Message-ID: <39B6A7A5.3EAF964F@mvista.com>
Date: Wed, 06 Sep 2000 13:23:01 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: question about 'r2' !!!
References: <Pine.LNX.4.10.10009061819050.23404-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > I am currently engaged in compiling Linux-ppc source tree using a CC other
> > > than GCC.
> >
> > May I ask you _why_ you want to do that?!?
>
> The mind fairly boggles. Anyway, once upon a time, current wasn't kept in
> a register but in memory. And if r2 won't do, just pick another register
> and tell the compiler not to touch it. Hope your compiler of choice has
> such a thing as --fixed-r2 ...
>
>         Michael
>

And if you want to use kgdb to debug your kernel, gdb knows that current is r2...

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <20000505133629.9993.qmail@web208.mail.yahoo.com>
Date: Fri, 5 May 2000 06:36:29 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re: SMP/DayStar x4
To: Steven Hanley <sjh@wibble.net>, Sacha Varma <sacha@ssl.co.uk>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linux supports smp on sparc for ages but linuxppc was
a late starter in the architecture independent part of
smp it only supported 2 cpus & very few interrupt
controllers on ppc upto about a year ago,

Look in smp_boot_cpus in arch/ppc/kernel/smp.c
& the switch(_machine) statment this will give you
some hint on whether your interrupt
controller/motherboard etc will work, if not it may be
a good idea to put printk's in all the case statments
if your not too sure which category your machine falls
into & recompile the kernel.

--- Steven Hanley <sjh@wibble.net> wrote:
>
> > only 2 processors are available.
> >
> > Can anyone set me straight?
>
> very wrong, smp even back when it was added in
> 1.3.something could
> handle more than two AFAIR, it was just very
> inefficient then. it is now
> a lot more efficient and scales a lot better. Dave
> Miller was using it
> on a 14 cpu ultra sparc pre 2.2.0 release, as for
> ppc, it works on 4 way
> ppc, I have no idea how it will work on your
> specific hardware though.
>
> 	See You
> 	    Steve
>
> --
> sjh@wibble.net http://wibble.net/~sjh/
> Look Up In The Sky
>    Is it a bird?  No
>       Is it a plane?  No
>          Is it a small blue banana?
> YES
>
>

=====
D.J. Barrow Linux for S/390 kernel developer
eMail: djbarrow@de.ibm.com,barrow_dj@yahoo.com
Phone: +49-(0)7031-16-2583
IBM Germany Lab, Schönaicherstr. 220, 71032 Böblingen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

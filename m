To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new bi_rec interface (was Re: [Ppcboot-users] Re: EV-64260 booting) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 18 Mar 2002 14:33:26 -0900."
             <20020318143326.B26309@plato.local.lan>
Date: Tue, 19 Mar 2002 01:24:49 +0100
Message-Id: <20020319002454.80D42109F1@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020318143326.B26309@plato.local.lan> you wrote:
>
> > What happened to the idea (paulus' idea?) of creating some wrapper
> > code (eg, zimage) that would build the bootinfo and pass it into
> > the kernel, so yaboot doesn't need to do much other than pass in
> > boot params?  This would force us to only boot zimages though
> > (or whatever wrapper code we create).
>
> from a logistical point of view this really seems to be the best
> approach.  keeping all the details in a kernel wrapper of sorts gives

>From the point of view of someone who is working mostly with embedded
systems this is definitely the WORST approach (YMMV).

> the kernel maintainers much more freedom to make changes in the
> future, whereas if its kept in yaboot (rather $bootloader) you have to

The interfaces, once defined, should remain unchanged.

> deal with backword compatibility and endless luser error due to using
> the wrong bootloader versions with wrong kernels.

There is no need to create such problems in the first place, so don;t
do it then.

> of course if someone doesn't want to use the wrapper they can just use
> the vmlinux and write thier own bootloader to handle all this stuff
> and take on the effort of ensuring its up to date with what the kernel
> wants.

What makes you think that kernel interfaces are  somthing  to  change
that  often?  From  the  current  discussion  about bi_recs I got the
impression that we have some kind of  agreement  (in  pronciple,  not
[yet]  in  detail), but what you propose sounds like a full roll-back
to position zero???

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
C++ is the best example of second-system effect since OS/360.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

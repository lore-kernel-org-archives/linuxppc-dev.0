To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb load address and KERNELLOAD 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Apr 2001 11:30:56 EDT."
             <3ACB3E30.E17CC550@mvista.com>
Date: Wed, 04 Apr 2001 17:54:14 +0200
Message-Id: <20010404155419.8B369281DB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3ACB3E30.E17CC550@mvista.com> Dan Malek wrote:
>
> > The BDM4GDB  project  at  sourceforge  (see  bdm4gdb.sourceforge.net)
> > provides all necessary information to build a home-made parallel port
> > adapter  (schematics, source extension to GDB) which allows to do the
> > same.
>
> Really?  Like it handles all of the memory mapping details, too?

In fact the BDM4GDB had an implementation of MMU support  before  the
BDI200  had  it - credits to Frank Przybylski, who did all (and still
does most of) the work.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I often quote myself; it adds spice to my conversation.  - G. B. Shaw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

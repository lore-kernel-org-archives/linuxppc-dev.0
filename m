Message-Id: <199911261206.NAA23788@denx.local.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: bootloader & head.S weirdness & restructuring 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Nov 1999 10:42:03 +0100."
             <Pine.LNX.4.10.9911261032590.22448-100000@opal.biophys.uni-duesseldorf.de>
Date: Fri, 26 Nov 1999 13:06:21 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.4.10.9911261032590.22448-100000@opal.biophys.uni-duesseldorf.de>
Michael Schmitz wrote:

> > > >     #if defined(CONFIG_x) || defined(CONFIG_y) || defined(CONFIG_z)
> > > >     ...
> > > >     #endif
...
> Plus it has the added benefit that you can still build kernels that
> support a range of hardware (by making has_feature_a not const 0 or 1 but
> something like feature_present(a) :-) If you don't need this, both are
> equivalent though. 

This depends if the compiler has a chance to  decide  which  code  is
needed and which not. Otherwise it cannot optimize away dead code.

> Worried about wasting a few cycles on the branch? I've never noticed a

No, it's the code size that matters on  many  embedded  systems.  The
target  is  a minimal kernel code size. And improved performance is a
most welcome add-on.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"...one of the main causes of the fall of the Roman Empire was  that,
lacking  zero,  they had no way to indicate successful termination of
their C programs."                                     - Robert Firth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

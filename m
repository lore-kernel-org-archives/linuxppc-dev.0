Message-Id: <200004121349.PAA04256@denx.local.net>
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
cc: "'Kim J?rgensen'" <KIJ@infocom.dk>,
        "'linuxppc-embedded@lists.linuxppc.org'"@denx.local.net
Subject: Re: No bash prompt 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Apr 2000 08:12:50 EDT."
             <200004121212.IAA10789@hoover.gilbarco.com>
Date: Wed, 12 Apr 2000 15:09:38 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200004121212.IAA10789@hoover.gilbarco.com> you wrote:
>
> Are you trying to boot your board with a BDM plugged in?  If so, Dan made us
> aware that BDM's will fight with the kernel and will get confused about the
> VM.  If this is your situation, you will need to program your flash with the

It is true that  the  BDM  debuggers  usually  don't  understand  the
address mappings very well as soon as the MMU has been turned on, but
it is NOT TRUE that "BDM's will fight with the kernel".

So the BDM debugger might not be too helpful while Linux is  running,
but it does not cause any problems if you configure it correctly:

Depending on your settings of the Debug Enable Register (DER) you can
run  Linux  with  a  BDM  debugger  attached  without  any  problems;
0x6002000F or 0x2002000F might be useful settings - depending on what
you like.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

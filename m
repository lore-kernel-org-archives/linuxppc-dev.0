Message-Id: <199910260629.IAA20848@denx.local.net>
To: sorin@nitechinc.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dev boards comparison 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Oct 1999 09:48:15 EDT."
             <99102509535300.00577@splash.nitechinc.com>
Date: Tue, 26 Oct 1999 08:29:46 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Sorin,

in message <99102509535300.00577@splash.nitechinc.com> you write:
> 
> We're in the process of deciding which board to use for the 
> developement of our embedded products... we have now a
> FADS 860 board... but we aren't that much impressed by it.

Which CPU are you looking for?

> So can anyone please tell me which one is better from the 
> point of view of developing embedded solutions based on 
> Linux?
> We are considering the FADS, along with the MBX boards 
> from Motorola and the RPX boards from Embedded Planet
> Any pros and cons for this boards? 

I had 2 *very* early (F)ADS boards, but then we were  using  some  30
MBX  boards  for the rest of the projects (not for Linux, but this is
not really important here)... Guess why.  If  your  only  choice  was
between FADS and MBX I would use the MBX. Just my $0.02 ...

> Are there other boards that might be considered?

Probably yes. I am using the mini modules by TQ  Systems  in  several
projects,  see http://www.tqs.de/HTM_Files/TQM8xx_Serie.htm for hard-
ware desriptions).

The TQ starter kit, which functionally is very  similar  to  the  MBX
board, is intentionally somewhat cheaper.

But IMHO an even more interesting feature is the  separation  of  the
"mini  module"  (containing  CPU,  RAM,  SRAM and FLASH memory, power
supply, etc.), from the rest of the framework needed to make a usable
configuration (mostly connectors). This results in a neat, very small
module (less than half a credit card!), that can be  used  as-is  for
your  final application - all you have to design is a (simple, cheap)
carrier  board  with  what  you  need  for  external  circuitry   and
connectors  etc.  I  always found it very convenient that development
and target system are more or less identical, at least from the soft-
ware point of view.


I ported Linux to those modules (including the latest 2.2.13 kernel),
and I have sent my patches to Dan Malek; I hope they will show up  in
one  of  the  next "standard" embedded kernels. I'm going to continue
supporting these modules, both for new CPU configurations and for new
options (like FLASH filesystem).

Feel free to contact me if this looks like an interesting  option  to
you.

Hope this helps,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Defaults are wonderful, just like fire.
                  - Larry Wall in <1996Mar6.004121.27890@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

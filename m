To: jmouro@iol.pt
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA polling!?! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Jun 2003 15:51:55 BST."
             <5bf7b05c1bab.5c1bab5bf7b0@iol.pt>
Date: Wed, 11 Jun 2003 22:31:14 +0200
Message-Id: <20030611203119.34349C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jmouro,

in message <5bf7b05c1bab.5c1bab5bf7b0@iol.pt> you wrote:
>
> I'm working on a embedded system with a  TQM860L, and a I have a doubt that perhaps you might answer.
> I've 2 signals related with system defects (power supply defects) connected to PCMCIA channel II (IPBx). Is there a way to check if those signals where triggered without polling them? Like in interrupt lines? In that way I could

Maybe you can explain what exactly you are  trying  to  do?  Actually
there are 4 voltage detect lines: CBVS1/2 (Voltage Sense 1 and 2) and
CBBVD1/2  (Battery  Voltage  Detect 1 and 2). Interrupts can be abled
individualy for each of the 4 pins in  the  PCMCIA  Interface  Enable
Register.

But normally you don't have to care about this stuff - if you want to
use a PCMCIA Card with the system the PCMCIA  Card  Services  package
will  handle  all  such  events.  PCMCIA Card Service support for the
TQM8xxL modules / STK8xxL starter kit  is  ready  available  -  don't
re-invent the wheel.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Overdrawn?  But I still have checks left!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <200006301107.NAA04859@denx.local.net>
To: Ole.Reinartz@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org,
        Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de
Subject: Re: ISDN on MPC ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Jun 2000 12:36:32 +0300."
             <A914533BF4B9D2118D980008C7894C0A02D1EBD3@dueis01nok>
Date: Fri, 30 Jun 2000 13:07:57 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A914533BF4B9D2118D980008C7894C0A02D1EBD3@dueis01nok> you wrote:
>
> AFAIK the MPC860 µP's are designed especially to be used with existing
> telecom- designs, including existing ISDN chipsets. There should be support
> for SIEMENS' GCI(2) bus and the motorola own bus (forgot the name). There is
> also HDLC functionality in the CPM so that you are not forced to use an
> external framer.

Right, you can handle all this using the SCC's.  I  know  of  several
commercial  solutions  that  do  exactly that. Unfortunately, I don't
know of an Open Source project.

In our case we estimated  that  it  would  be  easier  (in  terms  of
development  effort)  to  interface  an  external  framer, and re-use
existing isdn4linux code as much as possible. Also,  using  a  PCMCIA
prototype  card,  it's  much  easier  to sort out some other problems
lioke endianess by running the same code  on  very  similar  hardware
both on the MPC8xx target and on a normal x86 laptop.

> I didnt actually integrate such things yet, but it is a spare time project I
> want to start one day.

Just let me know if you have any free manpower to offer :-)

> In isdn4linux there should be code to access some of the siemens chips (the
> ones most of the passive PC- isdn- cards are based on). Perhaps there could
> be some driver code you could base your design on.

That's what we're doing.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

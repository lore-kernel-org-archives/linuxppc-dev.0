Message-ID: <20001216050700.16326.qmail@web4605.mail.yahoo.com>
Date: Fri, 15 Dec 2000 21:07:00 -0800 (PST)
From: Jerry Nguyen <jerry_nguyen_75@yahoo.com>
Subject: Re: PCMCIA have machine check
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi ,

 Thank for all valuable advice. I have checked the
spec of Wireless LAN
 PCMCIA card, the wait signal is longer than the
setting of BMT. That
explain
 why we have the machine check.  My fix is modify the
the Machine Check
 Interrupt handler when read or write PCMCIA because
we still need monitor
 Machine check in some case and The driver work fine
now.

 Once again thank very much
 Jerry


> ----- Original Message -----
> From: <mlocke@jps.net>
> To: "Nguyen Xuan Hoang"
<jerry.nguyen@serialsystem.com.sg>
> Cc: <linuxppc-embedded@lists.linuxppc.org>;
<support@mvista.com>
> Sent: Wednesday, December 13, 2000 9:36 AM
> Subject: Re: PCMCIA have machine check
>
>
> >
> > You probably have the old RPX bootloader.  It sets
the Bus Montior
timeout
> > which causes machine checks for every IO
operation.  Contact EP tech
> support
> > and request PlanetCore, the new bootloader.
> > Nguyen Xuan Hoang wrote:
> >
> > > Hi,
> > >
> > > I am trying to run Wireless Lan PCMCIA on
RPXLite board,  but the
system
> > > just randomly crash (a machine check error).  I
have trace the error,
it
> > > happen when we read or write the I/O port on the
wireless LAN. It
seems
> the
> > > PCMCIA controller not set correctly. Have anyone
experience about this
> > > problem, please give me some advice.
> > >
> > > Thank in advance
> > > Jerry
> > >
> >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

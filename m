Message-Id: <200006291535.RAA26178@denx.local.net>
To: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ISDN on MPC ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Jun 2000 17:07:27 +0200."
             <Pine.GSO.4.21.0006291656470.11412-100000@samson.hrz.tu-chemnitz.de>
Date: Thu, 29 Jun 2000 17:35:10 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.GSO.4.21.0006291656470.11412-100000@samson.hrz.tu-chemnitz.de> you wrote:
>
> I have an MPC860 on an MBX-board running Linux 2.2.13 based on MontaVista
> sources. I want to add ISDN functionality. Has anyone of you already done
> work in this area ?

Not completed yet, but we are working on it.

The design is  based  on  the  HFC-SP  chips  by  Cologne  Chip,  see
http://www.colognechip.com/isdn/controllers/frame-hfc-sp.htm

> As far as I got it I have to write a new hardware-level driver for the
> isdn4linux subsystem, is that right ? Is anyone aware of special problems
> I have to focus ?

Interfacing the ISDN chips with the MPC8xx  bus  might  be  an  issue
(timing).  That's  why we selected a PCMCIA based design (although we
won't use a PCMCIA card).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Conscious is when you are aware of something, and conscience is  when
you wish you weren't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

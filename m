To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: "Kerl, John" <John.Kerl@Avnet.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx, FEC and DP83847 !? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Mar 2002 18:58:52 +0100."
             <3C9A1F5C.61673202@imc-berlin.de>
Date: Thu, 21 Mar 2002 19:25:38 +0100
Message-Id: <20020321182543.80EB9109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C9A1F5C.61673202@imc-berlin.de> you wrote:
>
> Ok. Since there are special options in DENX kernel for LXT, AMD and QS I
> thought special support for these PHYs is neccessary. Maybe only if you
> want to use the vendor specific special registers of the PHYs in
> addition to the standart MII register!?

It depends on hwat you have to do, and an the PHY.

In most cases ypu can just switch off the whole MDIO stuff  and  rely
on  autonegotiation; the only thing you lose is a kernel message when
the link status changes. Of course this requires sane hardware, which
is not always the case :-(

> > The Motorola reference boards use port D for MII, but we
> > used PCMCIA/port A pins instead.
>
> Why would you probably do this?
> I supposed you're using PORT D for something else!?

Probably.

> It would be really interessting to know...

See the ICU862 configuration in our sources. They do the same  thing,
and had similar problems...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
       There is enough for the need of everyone in this world,
       but not for the greed of everyone.     - Mahatma Gandhi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

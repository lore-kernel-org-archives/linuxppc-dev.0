To: Jerry Van Baren <vanbaren_gerald@si.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS? + MDIO 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Oct 2001 08:01:28 EDT."
             <4.3.2.20011008074637.00c64340@falcon.si.com>
Date: Mon, 08 Oct 2001 15:06:26 +0200
Message-Id: <20011008130631.E762D10883@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.3.2.20011008074637.00c64340@falcon.si.com> you wrote:
>
> For PPCBoot, I made MII serial interface routines for the EST
> (WindRiver) SBC8260 board.  This was a general purpose implementation,
> customizable for different hardware by changing the #defines that
> toggled the I/O port pins.  I also added a "mii" command that allows
> you to read and write the MII registers from the command line.  I was
> able to read and write the EnableSemi (Lucent) PHY, which is a "dongle"
> type PHY provided by EST.  This could be helpful for you for poking
> around in the PHY.  If your needs are not too complex, it may be
> sufficient to initialize the PHY and let it run autonomously.
>
> I submitted patches to Wolfgang, but it appears they have not been
> rolled into the source yet.  If you want a patch, reply to my email
> address and I'll send you one.

Sorry for the delay, but it's my first day  in  the  office  after  3
weeks  of vacation, and I'm still trying to figure out where to start
working on all the things that piled up...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
C makes it easy for you to shoot yourself in the foot. C++ makes that
harder, but when you do, it blows away your whole leg.
                                                 -- Bjarne Stroustrup

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

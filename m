Message-Id: <200101102333.f0ANXmj19544@denx.local.net>
To: Dan Malek <dan@mvista.com>
cc: "Gessner, Matt" <mattg@aiinet.com>,
        "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 860P FEC and fec driver from 2.3? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jan 2001 17:40:05 EST."
             <3A5CE4C5.E59163A1@mvista.com>
Date: Thu, 11 Jan 2001 00:33:48 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A5CE4C5.E59163A1@mvista.com> you wrote:
>
> "Gessner, Matt" wrote:
> >
> > Do this work?  I've got someone here who's got the LXT970 PHY
> > and the thing doesn't work with the driver from 2.3 I've got.
> > Has it changed?

It probably does not work with 2.3.x code; but then  -  I  never  got
lucky with any 2.3 code :-(

> There have been some changes through the course of 2.3 and 2.4.
> I think Wolfgang Denk finally fixed the FEC driver so it can be
> use in 2.4.  Some of the software modifications were driver
> interface related, and I made a couple because the MII pin
> configuration changed with > Rev. C of the parts.

Right. See our version of the sources in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src

Works fine in a couple of systems based on 860T and 860P  CPUs,  with
Level One 970 and 9880 and similar PHY's.

If your hardware does autoconfiguration you can omit most of the  PHY
recognistion  stuff;  otherwise enable it, but then you must assign a
PHY interrupt.

> The 860P certainly works, I use one almost every day for some
> kind of network activity.

Me too (in an ISDN router).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If that makes any sense to you, you have a big problem."
                                  -- C. Durance, Computer Science 234

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

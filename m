From: "Ron Bianco" <ronb@junction.net>
To: <mgreer@mvista.com>,
	"=?iso-8859-1?B?U+liYXN0aWVuIEP0dOk=?=" <scote1@matrox.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Stability of MontaVista's 2.4.0-test2-1.2.2-1
Date: Fri, 30 Mar 2001 16:25:54 -0800
Message-ID: <000a01c0b979$25c93aa0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3AC5146D.CB770D1B@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check out:

http://www.mot.com/SPS/PowerPC/teksupport/tools/DINK32/VERSION12/dinkindex.htm

Most of DINK source code is easily downloadable, and the full source is obtainable thru a Motorola rep.
Not sure if that link is to the most current version.

Cheers, Ron

> -----Original Message-----

> > Anyway, I have another question.  In the header from
> > arch/ppc/kernel/sandpoint_setup.c,I see the following comment:
> >  * The firmware on the sandpoint is called DINK (not my acronym :).  This
> > port
> >  * depends on DINK to do some basic initialization (e.g., initialize the
> > memory
> >  * ctlr) and to ensure that the processor is using MAP B (CHRP map).
> >
> > Since I don't really have a Sandpoint, and I don't have the DINK which
> > comes with it, I guess I will run into trouble.
> > Is there a place where I could find info on what I should do I exactly as
> > far as initialization goes?!?
>
> No, I don't know of any place you can go that would tell you what you have to
> init.  You could look at some of the open source firmwares that are out there
> which should give you a good idea.  If you have a JTAG probe, you can put it
> on a board similar to yours with known good firmware and look the host-bridge
> regs, etc to how it sets everything up.  I dunno...
>
> You will definitely need to have the PCI arbiter, power mgmt, memory
> controller, and certain bits in HID0 and L2CR (if you have an L2 ctlr on your
> processor) all set up correctly.  Maybe some board regs too.
>
> Mark
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

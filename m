From: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
To: Owen Waller <O.Waller@ee.qub.ac.uk>
Date: Mon, 1 Feb 1999 12:51:40 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: matroxfb, anybody? (More details...)
CC: dhiltgen@toocool.itslab.calpoly.edu, mlan@cpu.lu,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org
Message-ID: <1EDE67B39D1@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  1 Feb 99 at 11:35, Owen Waller wrote:
> > (my PReP does not have OF and I never saw it...) If you uncommented #define
> > above, be sure that you commented out complement part from
> > drivers/video/offb.c - otherwise matroxfb can be initialized twice, thus
> > you'll get two fb's per one hardware :-(
> Is there any way that this could be changed? I don't need my internal
> video (control) to work, but I'd rather have it and the matrox compiled
> into the one kernel without a hack. Unless Geert you know some way of
> "fudging" an non-OF card into the OF device tree? OR Petr could you
> possibly work in a #define construct so that Daniel's "hack" became
> official? (mind you neither of these are very general solutions).
There is a problem. What if you HAVE matrox in OF ? Of course,
I remove this #ifdef from driver and add some variable to ensure, that
driver will be initialized only once... And if matroxfb is not your primary
head, you can, as temporary solution, compile it as module. It should
work without problems then.
> Also does anybody know how this situation changes if you use BootX to boot
> (I don't so I can't comment on this). Would BootX map the mystique from
As I do not have anything with OF around here, tell me what you want
and I'll do it...
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

P.S.: I'm not on the list, so please CC me...
P.P.S.: Should not I remove whole #ifdef CONFIG_FB_OF from driver?
Is there anybody who uses this additional feature?

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

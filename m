Message-Id: <200007282231.XAA13942@hyperion.valhalla.net>
Date: Fri, 28 Jul 2000 23:31:57 +0100
Subject: Re: internal speakers on Pismo
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        matthias pfisterer <matthias.pfisterer@gmx.de>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,
> Ok, I got it working here too. I've pushed changes in my rsync tree
> (dmasound 2.2, I'll take care of 2.4 later, I'll send you patches, Iain).

:-)

> Basically, clearing the additional registers is not what made it work as
> I originally expected ! What made it work was _not_ to enable the
> parallel port output. However, it is needed on some machines. So what I
> did was to enable it conditionally in a way similar to what Darwin does.

In some of the Apple code there is a statement about initial reg. states.  I
was intending to check that we had got these set - however, what you've put
here makes me wonder if that'll break something else.

> I also fixed up detection of screamer chips.

Thanks, that was top of my list of things to do...

> Oddly, the master volume doesn't work (but the speaker volume does).

Hmmm... master vol works OK on the G3 minitower - but not on the 9600 or the
Lombard (IIRC both AWACS V2)

> Also, Apple code has some weird thing: They detect two different device-
> id's for new iMacs (DV/SE). One is an inverted version. But they only
> enable the parallel output one of them. I don't know if it's normal or if
> it's actually a bug in their code. I did the same thing but left the case
> of normal iMacDV in comments, so users of this machine can try and see if
> it helps. I suspect that like other iMacs, there's an I2C amplifier/SRS
> module that needs to be setup too, but I'm not completely sure.

I FW'd a copy of our summary the other day to the guy working on I2C - no
reply get.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

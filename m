Message-ID: <3982B587.31F515D4@gmx.de>
Date: Sat, 29 Jul 2000 12:44:23 +0200
From: Matthias Pfisterer <Matthias.Pfisterer@gmx.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: internal speakers on Pismo
References: <3981F1F7.9314DAD3@gmx.de> <20000728221634.5701@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Benjamin Herrenschmidt wrote:
>
> Ok, I got it working here too. I've pushed changes in my rsync tree
> (dmasound 2.2, I'll take care of 2.4 later, I'll send you patches, Iain).
>
> Basically, clearing the additional registers is not what made it work as
> I originally expected ! What made it work was _not_ to enable the
> parallel port output.

Huh? Are you shure about this? I tried this first (not setting these two
bits, but leaving the additional registers alone) and it didn't work.
Well, I haven't tried only setting the new registers but enable parallel
output. Perhaps I should.

 However, it is needed on some machines. So what I
> did was to enable it conditionally in a way similar to what Darwin does.
> I also fixed up detection of screamer chips.

> Oddly, the master volume doesn't work (but the speaker volume does).

I have no problems with this. I can use both independently from each
other. What exactely is the behaviour for you?

> Also, Apple code has some weird thing: They detect two different device-
> id's for new iMacs (DV/SE). One is an inverted version. But they only
> enable the parallel output one of them. I don't know if it's normal or if
> it's actually a bug in their code. I did the same thing but left the case
> of normal iMacDV in comments, so users of this machine can try and see if
> it helps. I suspect that like other iMacs, there's an I2C amplifier/SRS
> module that needs to be setup too, but I'm not completely sure.
>
> Ben.

--
Matthias Pfisterer	<mailto:Matthias.Pfisterer@gmx.de>

        Share your knowledge.
        It's a way to achieve immortality.

                 (from a nepalese mantra)

Java Sound Examples:
http://rupert.informatik.uni-stuttgart.de/~pfistere/jsexamples/
Tritonus, the open source implementation of the Java Sound API:
http://tritonus.sourceforge.net/
--------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

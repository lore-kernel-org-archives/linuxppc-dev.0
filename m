Message-ID: <39853AFC.11FFB9CD@relog.ch>
Date: Mon, 31 Jul 2000 10:38:20 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Matthias Pfisterer <Matthias.Pfisterer@gmx.de>,
        Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: internal speakers on Pismo
References: <3981F1F7.9314DAD3@gmx.de> <20000728221634.5701@192.168.1.10>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> Ok, I got it working here too. I've pushed changes in my rsync tree
> (dmasound 2.2, I'll take care of 2.4 later, I'll send you patches, Iain).
>
> Basically, clearing the additional registers is not what made it work as
> I originally expected ! What made it work was _not_ to enable the
> parallel port output. However, it is needed on some machines. So what I
> did was to enable it conditionally in a way similar to what Darwin does.
> I also fixed up detection of screamer chips.

Thanks Ben!


> Oddly, the master volume doesn't work (but the speaker volume does).

The Master Volume works for the headphone jack, as before.


Michel


PS: The fact that the speakers aren't automatically muted when headphones are
connected has created a rather embarassing situation for me on the train this
morning: I was happily listening to MP3s, when I realized lots of people were
looking at me... oh well :)

--
The computer revolution is over. The computers won.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3A521D22.3F5F0E30@schweiz.org>
Date: Tue, 02 Jan 2001 19:25:39 +0100
From: Catherine <a.tobler@schweiz.org>
Reply-To: a.tobler@schweiz.org
MIME-Version: 1.0
To: Viljo Viitanen <Viljo.Viitanen@helsinki.fi>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pcmcia interrupts & power key scancode on pismo powerbook
References: <NCEPLFKFPCEAOMFHNBNPIEFICEAA.Viljo.Viitanen@helsinki.fi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Viljo Viitanen wrote:

> Then, after trying to get pcmcia working (pcmcia 3.1.23+stock 2.2.18 says
> "*NO* card interrupts"), I finally came across this (long url, should be one
> line but outlook probably cuts it):
>
> http://www.google.com/search?q=cache:pcmcia.sourceforge.org/cgi-bin/HyperNew
> s/get/pcmcia/ports/10/1.html%3Fnogifs++site:pcmcia.sourceforge.org+pismo+pow
> erbook+success+pcmcia&hl=en
>
> But even with that patch, I get a kernel panic if I remove the card 'on
> fly', without cardctl eject (I'm fiddling with a lucent wavelan silver
> card).
>
> I can live with that even if it's a bit annoying, but what I'm curious about
> is why I could not find that patch in no other place than google's cache :)

Try the link here: http://www.mpifr-bonn.mpg.de/div/iri/Archiv/LinuxPPC/PCMCIA.html

It has also references to further pages. (eject etc.)

Cheers
Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

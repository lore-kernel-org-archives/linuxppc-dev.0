Message-Id: <200007261838.TAA21891@hyperion.valhalla.net>
Date: Wed, 26 Jul 2000 19:38:27 +0100
Subject: Re: sound again [was: Re: xf4 bug report]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Topi Kanerva <tkanerva@ees2.oulu.fi>, linuxppc-dev@lists.linuxppc.org,
        daenzerm@student.ethz.ch, SteffenH@hyperion-software.de,
        geert@linux-m68k.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I'd say that a summary of today's (most interesting) thread is...

That:

(a) There's no real difference in behaviour between the back-port and the
2.2.17preXX monolithic dmasound module.

(b) The finger of blame is still pointing where I suspected (i.e. the mixer
abstraction).

OK -

1/  Is there an "official" maintainer?

2/  If not, is there anyone else (other than me) who wants to volunteer to
get to the bottom of it?

3/ Is there any reason to work on the 2.2.17preXX monolithic version or can
we continue with the 2.4.0-testxx with conditionals? (my preference as it
will transport directly to 2.4.0).

FYI: there is another party working on the I2C bus to bring support to the
iBook etc. - I've already made contact but he wants to get things going
before merging...

I *am* willing to have a go at doing a further split & debug job (certainly
on the pmac stuff).  Is there any news as to whether the code is OK of the
other platforms?

Thanks everyone for your input & an exciting read after a long and tiring
day out of the office :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

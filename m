Subject: Re: linuxppc-2.5 fixlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ernst Persson <ernstp@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <8088727.1061649011686.JavaMail.ernstp@mac.com>
References: <8088727.1061649011686.JavaMail.ernstp@mac.com>
Content-Type: text/plain
Message-Id: <1061708975.786.23.camel@gaston>
Mime-Version: 1.0
Date: Sun, 24 Aug 2003 09:09:35 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-08-23 at 16:30, Ernst Persson wrote:
> >> Alsa does not seem to produce any sound, whatever I try to do
> >> (including messing around with mute), and dmasound doesn't compile at
> >> all.
> >>
> >> Used kernel is 2.6.0-test3, via rsync from
> >> source.mvista.com::linuxppc-2.5, as of around 10AM CET (8AM UTC).
> >
> >Typically enough, I was just pointed to a fix for this problem (for
> >alsa) a few minutes after sending this mail.
> >
> >According to
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0308.2/0288.html
> >reloading i2c-keywest after loading the alsa-modules initialised things
> >so that demuting works. There's also a patch included.

Please forward these to the Alsa maintainer Takashi Iwai <tiwai@suse.de>

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

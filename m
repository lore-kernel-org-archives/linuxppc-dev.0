Message-ID: <398E4300.4E84850F@ncal.verio.com>
Date: Sun, 06 Aug 2000 22:02:56 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org,
        Matthias Pfisterer <Matthias.Pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
References: <Pine.LNX.3.96LJ1.1b7.1000806202004.689I-100000@ofey.earthlink.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
>
> On Sun, 6 Aug 2000, Henry Worth wrote:
>
> [...]
> > This won't help in the esd case, it always sets the device to
> > AFMT_S16_BE for 16 bit data on big endian systems (also doesn't deal
> > with
> > unsigned 16 bit data streams). Whereas the XMMS esd output plugin always
> > passes the data through unchanged (little endian in the case of .wav).
>
> Does xmms' esd output plugin work with 16bit .wav at all on x86?  Since
> sox works just fine with 16bit .wav, and it doesn't do any byte swapping
> either as far as I know (which is not much admittedly), I'm very much
> inclined to think xmms+esd is plain broken with respect to 16bit wav.
>
> Takashi Oe

The esd daemon sets the output to native endiness, so on an x86
everyone is little endian and all should be well, but I haven't
tried it.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 7 Aug 2000 17:49:43 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org,
        matthias pfisterer <matthias.pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
In-Reply-To: <200008071935.UAA06527@hyperion.valhalla.net>
Message-ID: <Pine.SOL.4.10.10008071712010.22515-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A bit of a misunderstanding seems to have crept in. The
XMMS output plugins are responsible for converting the
data from the input plugin, which could be any standard
audio format for the general purpose audio plugins, to
one supported by the output destination (the esd daemon
in the case of the esd output plugin).

The XMMS framework itself cares little about the data format,
it could be just about anything, audio, video, image,.... Just
so the input and output plugins are agreeable to each other
(and any special effects plugins in use) and can pass that data
between each other on the defined interfaces.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

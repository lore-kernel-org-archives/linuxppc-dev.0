In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990929192816.20530A-100000@ofey.inetnebr.com>
Date: Thu, 30 Sep 1999 10:50:30 +0200
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Message-Id: <19990930105030.013866@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 29, 1999, Takashi Oe <toe@unlserve.unl.edu> wrote:

>I don't know of any major flaw, but the DMA code can use some testings.
>I've only tested it on Power Mac 7600 with baud rate of upto 115200 bps.

I've heard of various possible issues with DMA hardware on the serial
ports and G3 macs. There seem to be a problem with the Heathrow
generation of Apple ASICs. (This was reported to me by people who made a
special device that was plugged into those ports, with a custom driver
under MacOS). They told me some characters end up beeing garbled when
reaching the SCC. I'll do some testings with your driver and my
powerbook's internal modem this week end to see if this problem actually
occurs or not.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

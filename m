From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Iain Sandoe <iain@sandoe.co.uk>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: digital audio g4 failing at machine check
Date: Thu, 1 Mar 2001 15:05:36 +0100
Message-Id: <19350124073720.22307@mailhost.mipsys.com>
In-Reply-To: <20010301133724.18C50DB9D0@atlas.valhalla.net>
References: <20010301133724.18C50DB9D0@atlas.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>what is the "digital audio" hardware? - is it Apple Screamer/Awacs?
>
>or is the "audio" completely irrelevant to the problem?
>
>(we might have an interaction between Adaptec 2930 & sound showing on other
>much earlier PowerComputing models as well)

Those are the new G4s. They use yet a new audio chip which is on the I2S/
I2C bus (and also use various GPIOs for things like speaker mute). I
don't have much more details yet.

I don't think there is anything related between the sound chip and the
Adaptec card. Those old problems were possibly due to some bus bandwidth
problems & DBDMA bugs, I don't think KeyLargo is subject to such bugs.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

In-Reply-To: <Pine.LNX.4.05.9910181938290.401-100000@callisto.of.borg>
Date: Mon, 18 Oct 1999 20:00:44 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Support for Sawtooth (New G4) Motherboards
Message-Id: <19991018200044.028209@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 18, 1999, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> Finally, there is the sound, which is on an i2s bus. I don't know how
>> such a bus looks like, and so I don't know if I'll be able to make a
>> driver for this one, at least not immediately.
>
>i2s? Not i2c?

Yes, I2S. There's also a couple of I2C busses (one in the northbridge,
probably for the SDRAM config, the other one in the mac-io chip). 

This part of the device tree looks like that:

pci/mac-io
    ...
    /i2c
        /i2c-cereal
    /i2s
        /i2s-a
            /sound
        /i2s-b
    ...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

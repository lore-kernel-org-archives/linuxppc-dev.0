Message-ID: <39905F08.F3E75A26@embeddededge.com>
Date: Tue, 08 Aug 2000 15:27:04 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Matthew Locke <mlocke@mvista.com>
CC: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>,
        "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C,SPI and QMC
References: <819E3E914E0AD11194DE00805F0D100B0138B86C@fbi.infocom.dk> <398EE632.D9A867E@vas-gmbh.de> <398EF507.AA56B9FF@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew Locke wrote:

> I have successfully used SPI with ethernet on SCC2 with the microcode
> patch.

Better than me :-)!  I left my attempt at microcode patches around
someplace, but was never able to make them work very well.

Depending upon your SPI or I2C requirements, you may just be able to
toggle the pins in software.  This is all I did.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

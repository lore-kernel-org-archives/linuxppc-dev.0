Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: problems running I2C and/or SPI on 857 board
Date: Mon, 25 Mar 2002 13:59:23 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJCEMMCDAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I'm trying to get I2C and/or SPI running on a 857 board. Register settings
and BDs look good. But when the start command is issued nearly nothing
happens as if there would be no clock.
TxBDs have ready bit set. Both ports initialize the internal BD pointer. SPI
is changing the clock line to inactive level (once). But that's all.
Couldn't find an errata that fits. Only the stuff with Parameter RAM
relocation but I can live with the default location...

Is there anyone who has an idea?

Thanks, Stephan

P.S.: Are the BD offsets counted from IMMR base, DPRam base or ...?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

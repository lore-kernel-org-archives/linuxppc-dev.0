Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B12@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: Pavel Bartusek <pba@sysgo.de>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MDIO clock speed computation
Date: Tue, 23 Jul 2002 15:41:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> I never expected to see someone run something like 46.5 MHz.

I agree, this might be impossible to achieve, since the PLL gain is an
integer. But the externcal clock does not necessarily have a frequency which
is a multiple of 1MHz.

For example, some of our 860T based boards have an external clock of
4096kHz, which is multiplied by 12, and yields a core clock of 49152MHz.

I don't know much about clock devices, but I guess there are many
possibilities.

> Will this work for all cases? :
>
> ((((bd->bi_intfreq + 4999999) / 2500000) / 2 ) & 0x3F ) << 1;

I hope so ;-)


--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 bios
Date: Thu, 8 May 2003 06:35:39 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEHGEFAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a BIOS, not as capable as u-boot, but it runs totally out of flash
and dual-port RAM. This makes it very nice when bringing up boards since all
you need is flash and the processor functioning. It is fairly flexible and I
have several maintenance type menus for playing with the various 8260
peripherals. I really like the initialization because it is table driven and
the code fits within the 256 bytes of the reset exception vector.

Does this sound useful?

Recommendations for where it should be posted? (source forge, BK, Motorola
some how?)

Suggestions?

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Sylvain Latulippe" <slatulippe@mediatrix.com>,
	"'Michael Thompson'" <mickey@berkeley.innomedia.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Are 8260 and 8250 CPM interface compatible?
Date: Fri, 27 Sep 2002 06:25:13 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEJJDMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B0CAD26@mail1.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> We have tested ethernet (fcc_enet.c), serial port (uart.c) from
> linux 2.4.19
> and it works fine.

Considering that Motorola is now using the CPM in multiple processors, including DSPs, would it make sense to breakout the support from the 8260 implementation and make it an independent option like PCI?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

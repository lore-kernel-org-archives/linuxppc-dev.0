To: bh40@calva.net
Cc: ad@mpifr-bonn.mpg.de, roikawa@rr.iij4u.or.jp,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: FireWire + Apple PB G3: some success
In-Reply-To: Your message of "Tue, 29 Feb 2000 17:45:47 +0100"
	<20000229174547.008164@mailhost.mipsys.com>
References: <20000229174547.008164@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000303022240B.roikawa@rr.iij4u.or.jp>
Date: Fri, 03 Mar 2000 02:22:40 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: FireWire + Apple PB G3: some success
> BTW. I didn't find register infos in the datasheet for the TI-1131. Do
> you have those ? I'd be interested. I found only the pinout and
No, I didn't find any register information except application report
on interrupts(I'll send it to you if necessary, which is just a 115K PDF)
probably because it is obsolete. But you can find it in the pcmcia-cs
package, whose auther may have a document(though I'm not quite sure).

BBTW, I'm new in the MOL source and I need some information/explanation.
Today I tried to add RageLTPro OF properties to MOL oftree.nw,
insert it into the pci device tree and mmu map full 16MB aperture
in thw video driver(on PB G3). I could run the drawing engine within
MacOS manually, but ATI's extension didn't seem to recognize the chip
at all. I even tried to load & insert into the driver properties field
the driver extracted from ATI Driver update file, but no success.
I don't understand MOL interface mechanism yet(and unfortunately
my macos complier, symantec c++ doesn't work on recent system).

What is the correct way to accelerate MOL video?

Thanks,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

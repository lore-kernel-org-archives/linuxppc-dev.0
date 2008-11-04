Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 1875BDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 02:49:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: LSISAS3041E-R PCIe card bring up failed on AMCC Canyonlands
Date: Tue, 4 Nov 2008 09:49:18 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F855@tanisys-ex2.Tanisys.Local>
In-Reply-To: <9a53cf970811032218j6f4817b8vf3f3197e81535f88@mail.gmail.com>
References: <9a53cf970811021916w57a91188ma126591932b78feb@mail.gmail.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F84E@tanisys-ex2.Tanisys.Local>
	<9a53cf970811032218j6f4817b8vf3f3197e81535f88@mail.gmail.com>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: "Minh Tuan Duong" <minhtuanmt1@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Minh Tuan Duong <mailto:minhtuanmt1@gmail.com> said on Tuesday, November
04, 2008 12:18 AM:

> Thanks Ayman.
> I applied the patch but it's still no progress. Do you have any
> suggestion?=20

I looked back at the log and it seems that the PCIE device link was ok.
That seems odd that it would not work later unless for some reason it
was disabled.  So a few things you could try a) verify that the board
you are using works in a PC w/linux for instance.  b) Try to load the
driver for the electronics (for instance, the particular flavor of SATA
controller).

Secondly, have you tried a recent kernel + device tree?

Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 2ECF2DDF92
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 02:49:20 +1100 (EST)
Subject: RE: LSISAS3041E-R PCIe card bring up failed on AMCC Canyonlands
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 3 Nov 2008 09:49:17 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F84E@tanisys-ex2.Tanisys.Local>
In-Reply-To: <9a53cf970811021916w57a91188ma126591932b78feb@mail.gmail.com>
References: <9a53cf970811021916w57a91188ma126591932b78feb@mail.gmail.com>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: "Minh Tuan Duong" <minhtuanmt1@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Minh Tuan Duong <> said on Sunday, November 02, 2008 9:17 PM:

> I am having some problems with AMCC Canyonlands' PCIe. I've tried to
> bring up LSISAS3041E-R PCIe card with Canyonlands but failed. It
> seems PCIe card can be detected in U-boot but Linux (kernel
> linux-2.6-denx). I also followed advice at
> http://marc.info/?l=3Dlinux-netdev&m=3D121602350226912&w=3D2 applying
> kernel 2.6.26 from kernel.org but nothing is progress. Log file is
> attached. Please let me know if you have any idea.    =20

Looking at your log file it appears that your device has a host bridge
on it.  Recently we had the same problem and some patches have just=20
been put in for handling PCI-E secondary busses.  You will have to
either
put the patches in or pull a recent tree.  The exact details and patch
are
on linuxppc-dev, subject "Workaround invalid P2P bridge bus numbers".
I've
confirmed that it does function on the Canyonlands using a couple of=20
different devices.

Best Regards,
Ayman

Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DA86E679E6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Jun 2006 23:25:47 +1000 (EST)
Date: Mon, 26 Jun 2006 17:25:46 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Florian Boelstler <euphoria@arcor.de>
Subject: Re: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Message-ID: <20060626172546.6bc37173@vitb.ru.mvista.com>
In-Reply-To: <e7oe1r$k2o$1@sea.gmane.org>
References: <e7oe1r$k2o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 26 Jun 2006 12:48:27 +0200
Florian Boelstler <euphoria@arcor.de> wrote:

> Hi,
>=20
> I am currently working on a MPC8548-based development system.
> Linux kernel version is 2.6.11 with patches delivered from Freescale=20
> (BSP MPC8548CDS 02/24/2006).
>=20
> Kernel configuration contains a warning message for CONFIG_PEX:
> "This requires hardware modification to work correctly if your CPU=20
> version < 2.0 and will break the PCI bus. [...]"
>=20
> I was wondering whether enabling PCIe makes PCI bus functionality=20
> unusable at all (including kernel functionality for detecting devices=20
> behind a transparent PCI-to-PCI bridge).
>=20
IIRC,yes.

> Our setup connects a transparent PLX8516 PCI-to-PCI bridge to the PCIe=20
> port of the MPC8548 daughter board. Behind that bridge is another PCIe=20
> capable device.
> MPC8548 is configured to run as PCIe host mode.
>=20
> When trying to lookup the PCIe devices using lspci I can only see the=20
> PPC itself and the bridge.
> However I cannot see the device(s) behind the bridge.
>=20

That's highly depends on silicon and Arcadia rev. you are using. There are =
some other details=20
about PCI-XP, but to inquire the certain information, you should contact FS=
L support.
> Is there another method for detecting PCI(e) devices?
> Is "BSP MPC8548CDS 02/24/2006" the latest version corresponding to that=20
> hardware?
>=20
=46rom what I know, yes, 2/24 is the latest. But you'll need some tricks in o=
rder to utilize PCI-xp...


--=20
Sincerely,=20
Vitaly

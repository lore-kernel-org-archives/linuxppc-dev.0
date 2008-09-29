Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 17412DDECA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Sep 2008 22:35:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PCI Bus Mapping for MPC8548 with multiple PCI interfaces
Date: Mon, 29 Sep 2008 14:35:10 +0200
References: <D0B748CCD5DF144CA5C56A9D860A31340FE1C0@men-exch1.intra.men.de>
In-Reply-To: <D0B748CCD5DF144CA5C56A9D860A31340FE1C0@men-exch1.intra.men.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809291435.10693.arnd@arndb.de>
Cc: Ralf =?iso-8859-1?q?Tr=FCbenbach?= <Ralf.Truebenbach@men.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 29 September 2008, Ralf Tr=FCbenbach wrote:
> Every bus is mapped independently. And PciConfigRead/Write functions
> convert the bus no. so that upper layers (and user) see a bus mapping
> similar to A). =20
>=20
> Maybe someone knows how U-Boot or Linux would map the interfaces?
>=20

You should use your option B) in the firmware, i.e. set up every PCI
independently from the others, startig at bus 0.

You should not fake the bus mapping but rather show the pci domains
separately to user space.

	Arnd <><

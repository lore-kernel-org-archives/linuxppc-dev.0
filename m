Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-nj2gw-1.online-age.net (ext-nj2gw-1.online-age.net
	[216.35.73.163]) by ozlabs.org (Postfix) with ESMTP id 66B472BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Dec 2004 02:24:53 +1100 (EST)
Received: from int-nj2gw-2.online-age.net (int-nj2gw-2 [3.159.236.66])
	by ext-nj2gw-1.online-age.net (8.12.9/8.12.9/990426-RLH) with ESMTP id
	iBKFG6BF015196 for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Dec 2004 10:16:07 -0500 (EST)
Received: from cinmlef07.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-nj2gw-2.online-age.net (8.12.9/8.12.8/990426-RLH) with ESMTP id
	iBKFG1Ql008186 for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Dec 2004 10:16:06 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 20 Dec 2004 09:17:02 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F204D1E5F9@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: IDE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a custom 440GX board with a Promise 20269.
even though, I used the options ide3=3Dnoprobe or hdg=3Dnoprobe and =
hdh=3Dnoprobe
Linux hangs on probing the second interface.=20
Am using the kernel options the correct way?

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PDC20269: IDE controller at PCI slot 00:03.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: ROM enabled at 0x000dc000
    ide2: BM-DMA at 0xefd0-0xefd7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xefd8-0xefdf, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: STI Flash 6.2.0, CFA DISK drive
blk: queue c01dbea0, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide3...

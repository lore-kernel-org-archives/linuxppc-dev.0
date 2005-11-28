Return-Path: <peter.fercher@scs.ch>
Received: from mail.scs.ch (mail.scs.ch [212.254.229.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2D80687FD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 21:17:03 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id jAS9xIit011204
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Nov 2005 10:59:18 +0100
Received: from mail.scs.ch ([127.0.0.1])
	by localhost (mail.scs.ch [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 11058-03 for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 10:59:14 +0100 (CET)
Received: from gull (219.scs.ch [212.254.229.219])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id jAS9xAeg011195
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Nov 2005 10:59:10 +0100
From: "Peter Fercher" <peter.fercher@scs.ch>
To: "'linux-ppc-embedded'" <linuxppc-embedded@ozlabs.org>
Date: Mon, 28 Nov 2005 10:59:10 +0100
Message-ID: <006101c5f402$613ac2c0$dbe5fed4@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: yosemite flash confusion
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,
the yosemite (revision 1.1) i got has a 512 MBit Flash chip on it
(S29GL512).
u-boot 1.1.3 that came with it was configured to use only 32 Mbytes ???

trying to use the whole size of the flashchip on the board I run into the
following problem:
when i try to use the u-boot.bin (newest from the denx homepage:
ftp://ftp.denx.de/pub/u-boot/images/amcc/yosemite/) then i get:
(reprogrammed using the yosemite.cfg that was mailed to this list some days
ago)
U-Boot 1.1.4 (Oct 24 2005 - 09:23:33)

AMCC PowerPC 440EP Rev. B
Board: Yosemite - AMCC PPC440EP Evaluation Board
        VCO: 1066 MHz
        CPU: 533 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        EPB: 66 MHz
        PCI: 66 MHz
I2C:   ready
DRAM:  256 MB
FLASH: 64 MB
*** Warning - bad CRC, using default environment

PCI:   Bus Dev VenId DevId Class Int
In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.

Type "run flash_nfs" to mount root filesystem over NFS

Hit any key to stop autoboot:  0

it sees the 64MB flash but somehow can't find the ethernet anymore..
does anybody know what the problem is there ?

cheers, peter

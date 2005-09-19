Return-Path: <peter.fercher@scs.ch>
Received: from mail.scs.ch (mail.scs.ch [212.254.229.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 687D668354
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 19:24:14 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j8J9GE32003044
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Sep 2005 11:16:14 +0200
Received: from mail.scs.ch ([127.0.0.1])
	by localhost (mail.scs.ch [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 02394-05 for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 11:16:11 +0200 (CEST)
Received: from gull (219.scs.ch [212.254.229.219])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j8J9G87D003021
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Sep 2005 11:16:08 +0200
From: "Peter Fercher" <peter.fercher@scs.ch>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Mon, 19 Sep 2005 11:16:08 +0200
Message-ID: <002e01c5bcfa$c500d860$dbe5fed4@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: kernel 2.6.12.2,
	octobus ppc405EP: GUNZIP ERROR - must RESET board to recover
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

trying to run a 2.6.12.2 on a octubus board i get.. (console print =
follows)



U-Boot 1.1.0 (May 11 2004 - 12:01:24)

=20

CPU:   IBM PowerPC 405EP Rev. B at 133.333 MHz (PLB=3D133, OPB=3D66, =
EBC=3D33 MHz)

       IIC Boot EEPROM disabled

       PCI async ext clock used, internal PCI arbiter enabled

       16 kB I-Cache 16 kB D-Cache

OCTOBUS Board: ### No HW ID - assuming OCTOBUS HPPC405

I2C:   ready

DRAM:  32 MB

FLASH:  4 MB

Hit any key to stop autoboot:  0

ENET Speed is 100 Mbps - FULL duplex connection

BOOTP broadcast 1

TFTP from server 192.168.1.1; our IP address is 192.168.1.2

Filename 'uImage-2.6.12.2'.

Load address: 0x100000

Loading: =
#################################################################

         =
#################################################################

         ##################################################

done

Bytes transferred =3D 919248 (e06d0 hex)

## Booting image at 00100000 ...

   Image Name:   Linux-2.6.12.2

   Created:      2005-09-19   9:03:08 UTC

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    919184 Bytes =3D 897.6 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... Error: inflate() returned -3

GUNZIP ERROR - must RESET board to recover.



any hints ?
cheers, peter

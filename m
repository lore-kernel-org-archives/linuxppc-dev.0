Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-nj2gw-3.online-age.net (ext-nj2gw-3.online-age.net
	[216.35.73.165]) by ozlabs.org (Postfix) with ESMTP id F20B967A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 01:22:57 +1100 (EST)
Received: from int-nj2gw-3.online-age.net (int-nj2gw-3 [3.159.236.67])
	by ext-nj2gw-3.online-age.net (8.12.9/8.12.9/990426-RLH) with ESMTP id
	j0JEMkjx024427 for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 09:22:49 -0500 (EST)
Received: from cinmlef07.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-nj2gw-3.online-age.net (8.12.9/8.12.8/990426-RLH) with ESMTP id
	j0JEMjA3008437 for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 09:22:46 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 19 Jan 2005 08:23:49 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F2054C18B8@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: task_no_data_intr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hda: STI Flash 6.2.0, CFA DISK drive
Probing IDE interface ide1...
ide0 at 0xeff8-0xefff,0xeff6 on irq 27
hda: attached ide-disk driver.
hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
hda: 500736 sectors (256 MB) w/1KiB Cache, CHS=3D978/16/32


Any idea why I would get the message about task_no_data_intr.
I am using a compact flash. Interrupt seems to work though.

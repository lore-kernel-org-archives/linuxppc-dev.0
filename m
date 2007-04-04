Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id D7C32DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 19:34:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: bootdev undefined
Date: Wed, 4 Apr 2007 11:34:05 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E71CD5E@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I modify my mtd flash partitions in flash based on information that I
read from a special sector in flash. The problem is that, then, I don't
know where the rootfs will be housed in. It could be in /dev/mtdblock2
or /dev/mtdblock3. Could I instruct the mtd subsystem to create a
special device beside the normal mtdblockn devices based on the info in
the partition table?
=20
Thank you in advance!=20

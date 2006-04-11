Return-Path: <lagrange@fr.oleane.com>
Received: from smtp6.clb.oleane.net (smtp6.clb.oleane.net [213.56.31.26])
	by ozlabs.org (Postfix) with ESMTP id 1FB8667B18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 02:31:46 +1000 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp6.clb.oleane.net with ESMTP id k3BGVdI0026663
	for <linuxppc-embedded@ozlabs.org>; Tue, 11 Apr 2006 18:31:43 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: NAND and JFFS2 supports in Linux 2.4
Date: Tue, 11 Apr 2006 18:31:18 +0200
Message-ID: <000001c65d85$5e699890$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I work on a custom 82xx board with a NAND flash :
NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V
8-bit)

I have to KEEP a Linux 2.4 and can't migrate to a Linux 2.6 for this board.

This type of NAND flash and JFFS2 work fine with a Linux 2.6 but with a
Linux 2.4,
this is a little tricky :
Linux 2.4.18 or 2.4.25 do not support this device,
Linux 2.4.31 seems supporting this device but JFFS2 is not adapted,
Linux 2.4.32 does not support this device anymore.

On www.linux-mtd.infradead.org, it seems that Linux 2.4 is no more
supported.

Any help would be welcome
Thanks
Laurent

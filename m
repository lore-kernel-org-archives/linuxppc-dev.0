Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 34E7CDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 19:36:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MTD concat
Date: Wed, 4 Apr 2007 11:36:24 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E71CD5F@aquib01a>
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

I have to flash mtds that are not contiguos. Let us say /dev/mtd2 and
/dev/mtd5 (representing two different areas in the same flash). Can I
mount a single jffs2 filesystem using both of them? Or can I create a
new /dev/mtdx grouping both /dev/mtd2 and /dev/mtd5?
=20
Thank you in advance!

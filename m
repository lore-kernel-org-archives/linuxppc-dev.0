MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: [PATCH] PPChameleon support for 2.6.7 kernel
Date: Tue, 29 Jun 2004 18:40:04 +0200
Message-ID: <80908CC5B2C9DB47AAF8C77892FCB44315F7C7@lion.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
here's attached patch for stock 2.6.7 kernel with support for the following features:
- PPChaneleon board itself;
- NOR boot flash (warning, you may easly destroy U-Boot);
- NAND support for both EVB and processor module flash chips (latest MTD/JFFS2 intergrated);
- GPIO suppport;

Obviously it may need some polishing however it seems to work and we've found such kernel to be very stable and fast.

Patch can be downloaded at http://hamlet.integra.com.ua/ppchameleon-2.6.7.patch.gz

regards,

--

Andriy Korud


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <a.korud@vector.com.pl>
Received: from 3bit.vector.com.pl (3bit.vector.com.pl [81.210.9.37])
	by ozlabs.org (Postfix) with ESMTP id 914DD67C37
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 02:34:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: U-Boot on 440EP Bamboo board, anybody succeed?
Date: Wed, 12 Apr 2006 18:22:08 +0200
Message-ID: <60E856FD577CC04BA3727AF4122D3F1601238501@3bit.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
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


Hi,
I'm trying to run U-Boot 1.1.4 on original 440EP Bamboo board and have =
two major problems:
1. Ethernets don't work, just "Net:   No ethernet found" on boot. In =
PIBS works.=20
2. When trying to boot uImage (loaded via USB, as eth doesn't work), it =
just hang after "Uncompressing Kernel Image ... OK". The same bzImage =
runs in PIBS.=20
U-Boot 1.1.4, Linux 2.6.16, compiled with gcc 3.4.5.

Does anybody succeed to run U-Boot on this board?

thanks in advance,=20
--
Andriy Korud=20

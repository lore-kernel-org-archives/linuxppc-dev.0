Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (exchange.tsi-telsys.com
	[205.230.130.11]) by ozlabs.org (Postfix) with ESMTP id 9559F679F5
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 07:34:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 2 May 2005 17:27:35 -0400
Message-ID: <0007F077BB3476449151699150E8FEA20592DE@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Endian Issue?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have linux (lk2.4.27-pre3) running on PPC440GX processor. The =
processor is connected to the Local PCI bus and to our custom device on =
this PCI bus. When we perform the DMA (or for that matter do =
memcpy_fromio()) from PCI bus memory to processor local memory, the data =
in the processor local memory is flipped (4 bytes at a time). Has anyone =
confronted this issue? Any ideas...

Thanks,
Sanjay

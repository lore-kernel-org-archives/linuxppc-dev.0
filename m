Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 932E8DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 07:46:05 +1000 (EST)
Subject: [PATCH 0/2] Move DTC Technical specs out of b-w-o.txt into DTC Repo
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1184190325.25384.125.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 11 Jul 2007 16:45:25 -0500
Cc: Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

Here are two patches, one to the kernel, the other to
the DTC repo, that moves the technical description
portions of the booting-without-of.txt documentation
out of the kernel and into the DTC repository.

Thanks,
jdl

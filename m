Return-Path: <Marc.Howard@kla-tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1DDF67A5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 11:14:49 +1000 (EST)
Received: from CA1EXBH02.adcorp.kla-tencor.com (ca1exbh02.kla-tencor.com
	[10.60.33.12])
	by ca1mail04.kla-tencor.com (8.12.10/8.12.11) with ESMTP id
	k3B0HXwK001367
	for <linuxppc-embedded@ozlabs.org>; Mon, 10 Apr 2006 17:17:33 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Create permanent mapping from PCI bus to region of physical memory
Date: Mon, 10 Apr 2006 17:17:32 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
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

I'm working on a PPC440GX based board in which a PCI based peripheral
communicates with the host via a shared region of processor memory.  The
peripheral will read and write this region autonomously.  Because of
this I need a fixed mapping FROM the PCI bus TO system memory.

It's easy enough to rope off the top 16 MB or so of system physical
memory by lying to linux in the boot arguments.  What I can't seem find
is a system call to use to create a fixed, permanent mapping of PPC
memory as seen from the PCI bus.

Has anyone out there done this and could share a code snippet with me?

Thanks,

Marc W. Howard

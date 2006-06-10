Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB9FD67C3F
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 10:34:42 +1000 (EST)
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20060608205048.113800@gmx.net>
References: <20060608205048.113800@gmx.net>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 10:34:25 +1000
Message-Id: <1149899665.12687.95.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This leads me to the question, if there are any plans to include the dma_mmap_coherent() function (for powerpc/ppc and/or any other platform) in one of the next kernel versions and if an adapation of the ALSA drivers is planned. Or is there a simple way (hack) to fix this problem?

You are welcome to do a patch implementing this :)

Ben.

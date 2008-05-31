Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF7E8DDF1B
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 12:20:15 +1000 (EST)
Message-ID: <4840B5DA.6020708@pobox.com>
Date: Fri, 30 May 2008 22:20:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 1/2] net: OpenFirmware GPIO based MDIO bitbang driver
References: <200805261152.37636.laurentp@cse-semaphore.com>
	<200805261153.21932.laurentp@cse-semaphore.com>
In-Reply-To: <200805261153.21932.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> This patch adds an MDIO bitbang driver that uses the GPIO library and its
> OF bindings to access the bus I/Os.
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   21 +++
>  drivers/net/phy/Kconfig                      |    6 +
>  drivers/net/phy/Makefile                     |    1 +
>  drivers/net/phy/mdio-ofgpio.c                |  205 ++++++++++++++++++++++++++
>  4 files changed, 233 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/phy/mdio-ofgpio.c

applied 1-2

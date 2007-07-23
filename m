Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5492CDDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 07:30:13 +1000 (EST)
Message-ID: <46A51DDD.8090205@freescale.com>
Date: Mon, 23 Jul 2007 16:30:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 23/25] [POWERPC] 85xxCDS: MPC8548 DTS cleanup.
References: <11852238122538-git-send-email-galak@kernel.crashing.org>	<11852238241475-git-send-email-galak@kernel.crashing.org>	<11852238253550-git-send-email-galak@kernel.crashing.org>	<11852238271141-git-send-email-galak@kernel.crashing.org>	<11852238283648-git-send-email-galak@kernel.crashing.org>	<1185223830411-git-send-email-galak@kernel.crashing.org>	<11852238322319-git-send-email-galak@kernel.crashing.org>	<11852238333649-git-send-email-galak@kernel.crashing.org>	<11852238353292-git-send-email-galak@kernel.crashing.org>	<11852238362041-git-send-email-galak@kernel.crashing.org>	<11852238383453-git-send-email-galak@kernel.crashing.org>	<11852238392809-git-send-email-galak@kernel.crashing.org>	<11852238411823-git-send-email-galak@kernel.crashing.org>	<11852238421611-git-send-email-galak@kernel.crashing.org>	<11852238432011-git-send-email-galak@kernel.crashing.org>	<11852238452609-git-send-email-galak@kernel.crashing.org>
	<11852238472931-git-send-email-galak@kernel.crashi! ng.org>
In-Reply-To: <11852238472931-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> +			pci_bridge@1c {

The OF PCI specification recommends "pci" here rather than "pci_bridge".
In any case, we should prefer dashes to underscores in device trees.

-Scott

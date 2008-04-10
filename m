Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73F0ADDF4F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 07:59:21 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804101537.27417.sr@denx.de>
References: <1207149149-17107-1-git-send-email-sr@denx.de>
	<200804101359.32095.sr@denx.de> <1207830182.6958.11.camel@pasglop>
	<200804101537.27417.sr@denx.de>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 07:58:48 +1000
Message-Id: <1207864728.6958.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-10 at 15:37 +0200, Stefan Roese wrote:
> 
> Now I have to re-check to see what you really have in mind. Do you think about 
> creating two different PCIe nodes, one for root-complex and one for endpoint 
> functionality? Or is your idea to add a property to the existing PCIe 
> device-tree node (like "mode = endpoint"), or perhaps change the device_type 
> from "pci" to "pci-endpoint"? I would vote for the latter.

Make the name and type of the node different. The rest can mostly stay
the same.

Cheers,
Ben.

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EECBDDEC9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 16:48:29 +1000 (EST)
In-Reply-To: <1181186378.10296.41.camel@localhost.localdomain>
References: <1181186378.10296.41.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D373FFB6-49B6-414B-AEEB-65AB62EB5AD5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH]: Add 8548 pcie bus number workaround
Date: Thu, 7 Jun 2007 01:48:40 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2007, at 10:19 PM, Zang Roy-r61911 wrote:

>
> From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
>
> Remove legacy pcie support for 8641 chip.
> General PCI code can fully support 8641 Rev2.0 chip.
> For 8548 PEX controller, PCIE host controller configure
> space can only be accessed as "bus->number = 0" in
> the PCI architecture. So "bus->number == hose->bus_offset"
> judgment is added.

Uugh, I'm completely confused.  Does 8548 rev 2.x have some errata  
(or 'feature') that 8641 doesn't have?

- k

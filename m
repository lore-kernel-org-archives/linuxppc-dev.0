Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E785DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 12:27:59 +1000 (EST)
In-Reply-To: <1185241179.5439.185.camel@localhost.localdomain>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<1185241179.5439.185.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0BB3DD1C-01B2-4C53-88FC-00F7B09096A9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 04/25] [POWERPC] Added indirect quirk to handle PCIe PHB
	that have issue w/no link
Date: Mon, 23 Jul 2007 21:28:43 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 23, 2007, at 8:39 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2007-07-23 at 15:49 -0500, Kumar Gala wrote:
>> Added PPC_INDIRECT_TYPE_NO_PCIE_LINK flag to the indirect pci  
>> handling
>> code to ensure that we don't talk to any device other than the PHB
>> if we don't have PCIe link.  Some controllers will lockup if they try
>> to do a config cycle to any device on the bus except the PHB.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> I would name the quirk a bit more generically, something like
> "ACCESS_PHB_ONLY" maybe ? If you don't want to change it, that's fair.

Will deal with this change after the current patchset.

>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Ben.

- k

Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E3E6DDF56
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 03:13:08 +1000 (EST)
In-Reply-To: <1184321144.30789.45.camel@localhost.localdomain>
References: <1184321144.30789.45.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4FE02857-7633-4A91-B0E5-A83E1B369B70@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2]  Add PCI/PCI Express node for 8544DS board]
Date: Mon, 16 Jul 2007 19:12:50 +0200
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

It looks real good now :-)

One tiny comment...

> +		pci@a000 {
> +			compatible = "fsl,mpc8548-pcie";

I would name the node pcie@a000 instead; generic names
aren't for machine consumption anyway, and most humans
want to know which buses are plain PCI vs. PCI-X vs.
PCI Express.

This could be changed with a follow-up patch of course.


Segher

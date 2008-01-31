Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9006DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 17:16:39 +1100 (EST)
Message-Id: <F84DDA3A-AF43-4E88-B971-2C9C89733FF1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <ABF87B0B6A38C0458E319AC973ED68AEBD0683@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/6] Change RIO function mpc85xx_ to fsl_ .
Date: Thu, 31 Jan 2008 00:15:07 -0600
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<A3EAB036-F69D-48DD-8CA9-4EAAE63AE1F5@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0683@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 12:04 AM, Zhang Wei wrote:

> All right, I'll give you another patch for 86xx dts file. :)
>
> Btw: Why the PCI and other nodes were moved from SOC? Just for clear?
> If they are moved out, their register address must use full address  
> not
> offset address.

we did this because the feeling was the SOC node just represented the  
IMMR/CCSBAR registers, and not the address space used by the various  
busses.

(this is why pci, rio, and local bus all exist outside of the soc node).

- k

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CA9B67D4B
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 15:42:04 +1100 (EST)
Subject: Re: [PATCH 7/32] powerpc: Make pci_read_irq_line the default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1163478030.3472.9.camel@localhost.localdomain>
References: <20061111062522.34CAC68047@ozlabs.org>
	<1163478030.3472.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 15:41:56 +1100
Message-Id: <1163479316.5940.96.camel@localhost.localdomain>
Mime-Version: 1.0
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


> Paul
> 	I checked your updated git tree just now.
> 	I have seen that you applied Ben's patch on mpc7448hpc2 platform about
> the "pci_read_irq_line".
> 	Could you discard this part in Ben's patch and apply mine:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027295.html
> http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027340.html
> 	
> 	Ben must forget this part of patch in his new serial patches.
> 	Thanks.

Can you instead send a patch that change my code into yours ?

Cheers,
Ben.

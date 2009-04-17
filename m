Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF920DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:26:06 +1000 (EST)
Subject: Re: pci32 code - early_*config*
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
References: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:25:59 +0200
Message-Id: <1239953159.7443.33.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-15 at 01:17 -0500, Kumar Gala wrote:
> Ben,
> 
> I was looking at what I need to get some additional bits of PCI code  
> building w/your ppc64 booke patches.  One thing it looks like we need  
> is the early config cycle code.  The question I have is do we think we  
> still need the null_ops support?  Also do we think we every get called  
> with a NULL hose?
> 
> This is fake_pci_bus() in arch/powerpc/kernel/pci_32.c

Hrm.

I'm not fan of the early config stuff, remind me why we need it ?

Ben.

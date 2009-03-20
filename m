Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4DDBDDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:48:35 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: Add support for CoreInt delivery of
	interrupts on MPIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1236784730-616-1-git-send-email-galak@kernel.crashing.org>
References: <1236784730-616-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 16:48:29 +1100
Message-Id: <1237528109.25062.568.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-03-11 at 10:18 -0500, Kumar Gala wrote:
> CoreInt provides a mechansim to deliver the IRQ vector directly
> into the core on an interrupt (via the SPR EPR) rather than having
> to go IACK on the PIC.  This is suppose to provide an improvment
> in interrupt latency by reducing the time to get the IRQ vector.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Fixed MPIC_GREG_GCONF_COREINT flag to be 0x60000000 as per spec and pointed about by Dave

Are you sure ? That's 2 bits ...

Ben.

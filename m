Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FD6EDDE1C
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 08:25:10 +1100 (EST)
Subject: Re: CONFIG_DEBUG_PAGEALLOC generates WARN_ON() in ppc32 hash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B8DDC536-3E6B-4857-B3B0-B8DE15D24A96@kernel.crashing.org>
References: <765C1EA1-93F7-4FEF-930B-78E2B3DEB4FA@kernel.crashing.org>
	<1238195157.20197.81.camel@pasglop>
	<B8DDC536-3E6B-4857-B3B0-B8DE15D24A96@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 29 Mar 2009 08:25:04 +1100
Message-Id: <1238275504.20197.92.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Note that C_D_P doesn't work on hash32 anyway...
> 
> really, what mmu config does it work on ? just hash64?

Pretty much :-) It's implemented for hash32 but there are issues
with the BAT mapping that were never quite resolved.

Cheers,
Ben.

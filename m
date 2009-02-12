Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6119DDED2
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 09:04:45 +1100 (EST)
Subject: Re: [PATCH v2] powerpc/fsl-booke: Add new ISA 2.06 page sizes and
	MAS defines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <54A20554-3C7B-4EE7-B3CF-362AEB27CA64@kernel.crashing.org>
References: <1234311976-22026-1-git-send-email-galak@kernel.crashing.org>
	<4B32B56D-9BCC-4ABA-A2AD-BCACFB30D18F@kernel.crashing.org>
	<20090212203409.GA2385@yoda.jdub.homelinux.org>
	<54A20554-3C7B-4EE7-B3CF-362AEB27CA64@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 09:04:35 +1100
Message-Id: <1234476275.29851.68.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I can call it mmu-book3e.h if you think that might enough different to  
> convey the ISA 2.06 fact that the FSL style MMU is now part of the 3e  
> architecture.

That's better. book3e is what I've been using internally...

Cheers,
Ben.

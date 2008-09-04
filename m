Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE160DDECF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 12:55:46 +1000 (EST)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support
	36-bit physical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <779A7F07-8988-47A2-85BF-B92FF33A8935@freescale.com>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<1220246399.13010.25.camel@pasglop>
	<44677536-2308-40AF-8844-7192489664B9@freescale.com>
	<1220390478.13010.163.camel@pasglop>
	<779A7F07-8988-47A2-85BF-B92FF33A8935@freescale.com>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 12:53:37 +1000
Message-Id: <1220496817.4879.22.camel@pasglop>
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

On Wed, 2008-09-03 at 10:10 -0500, Becky Bruce wrote:

> Actually, PTE_SIZE is already defined in hash_low_32.S, and it's the  
> size of the HPTE.  I'll rename that to HPTE_SIZE and use PTE_SIZE for  
> the linux PTE.

Good idea. Thanks.

Cheers,
Ben.

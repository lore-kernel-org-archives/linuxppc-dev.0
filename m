Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42A1268847
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Dec 2005 11:29:59 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
In-Reply-To: <20051202080711.GA32759@obsidianresearch.com>
References: <20051202080711.GA32759@obsidianresearch.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 11:22:37 +1100
Message-Id: <1133742158.6100.119.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.15-rc4] ppc32: Fixes for non-zero PPC_MEMSTART on
	PPC440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-12-02 at 01:07 -0700, Jason Gunthorpe wrote:
> I have a custom embedded system with a 440GP derived CPU that places the
> memory starting at 0xc0000000 which requires a non-zero PPC_MEMSTART. There
> are a couple of places that assume PPC_MEMSTART is 0. This results in
> various tricky crashing during booting. Most of the problems are
> not accounting for PPC_MEMSTART during va/pa translations. My fixes
> convert these places to use pre-existing macros instead of duplicating
> the calculation.

Just out of curiosity: why did you do such a bogus setup in the first
place ?

Ben.

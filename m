Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEF10DE3D5
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:48:30 +1000 (EST)
Message-Id: <E7B3F40E-3AE7-4A5B-B7A5-5FFCA68F9009@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <24aa9b0751e6ac616d6baf10da39163332bec0a8.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 07/14] powerpc: Add PPC_NOP_INSTR,
	a hash define for the preferred nop instruction
Date: Tue, 24 Jun 2008 08:48:20 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<24aa9b0751e6ac616d6baf10da39163332bec0a8.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:

> A bunch of code has hard-coded the value for a "nop" instruction, it
> would be nice to have a #define for it.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k

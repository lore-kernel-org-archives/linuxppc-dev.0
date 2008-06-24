Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3017DE4C3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:48:36 +1000 (EST)
Message-Id: <0FC448D9-12B9-42D7-85ED-A11675DD994C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <9fec814475d493f620af7ea7d5208eaa0180b6d9.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 09/14] powerpc: Consolidate CPU and firmware feature fixup
	macros
Date: Tue, 24 Jun 2008 08:48:25 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<9fec814475d493f620af7ea7d5208eaa0180b6d9.1214271072.git.michael@ellerman.id.au>
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

> The CPU and firmware feature fixup macros are currently spread across
> three files, firmware.h, cputable.h and asm-compat.h. Consolidate them
> into their own file, feature-fixups.h
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k

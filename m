Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32D93B70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:39:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E0ECDDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:39:48 +1000 (EST)
Message-Id: <D859494F-D5C8-42DD-87C3-16C39847987B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090723055953.B6F57DDD1B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 7/20] powerpc: Modify some ppc_asm.h macros to accomodate
	64-bits Book3E
Date: Thu, 23 Jul 2009 09:39:37 -0500
References: <20090723055953.B6F57DDD1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2009, at 12:59 AM, Benjamin Herrenschmidt wrote:

> The way I intend to use tophys/tovirt on 64-bit BookE is different
> from the "trick" that we currently play for 32-bit BookE so change
> the condition of definition of these macros to make it so.
>
> Also, make sure we only use rfid and mtmsrd instead of rfi and mtmsr
> for 64-bit server processors, not all 64-bit processors.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k

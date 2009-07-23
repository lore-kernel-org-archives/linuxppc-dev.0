Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 43C0BB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:44:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80E88DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:44:36 +1000 (EST)
Message-Id: <1E595D96-6A35-42E4-B2E4-8766AF8FDED7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090723055959.0D67DDDD1B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 13/20] powerpc: Add SPR definitions for new 64-bit BookE
Date: Thu, 23 Jul 2009 09:44:29 -0500
References: <20090723055959.0D67DDDD1B@ozlabs.org>
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

> +/* Bit definitions for EPCR */
> +#define SPRN_EPCR_EXTGS		0x80000000
> +#define SPRN_EPCR_DTLBGS	0x40000000
> +#define SPRN_EPCR_ITLBGS	0x20000000
> +#define SPRN_EPCR_DSIGS		0x10000000
> +#define SPRN_EPCR_ISIGS		0x08000000
> +#define SPRN_EPCR_DUVD		0x04000000
> +#define SPRN_EPCR_ICM		0x02000000
> +#define SPRN_EPCR_GICM		0x01000000
> +#define SPRN_EPCR_DGTMI		0x00800000
> +#define SPRN_EPCR_DMIUH		0x00400000
> +
> +

how about adding some comments as to what these fields are called.

- k

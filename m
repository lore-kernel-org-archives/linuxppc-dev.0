Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58A6067A3E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 10:48:34 +1000 (EST)
Subject: Re: [PATCH/2.6.17-rc4 2/10] Powerpc: Add Tundra Semiconductor
	tsi108  macro define
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626D61C@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626D61C@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 10:48:23 +1000
Message-Id: <1147913303.10703.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +/* Mapping of MPIC outputs to processors' interrupt pins */
> +
> +#define IDIR_INT_OUT0		0x1
> +#define IDIR_INT_OUT1		0x2
> +#define IDIR_INT_OUT2		0x4
> +#define IDIR_INT_OUT3		0x8

All this mapping should be provided by the device-tree

> +/* Error codes */
> +
> +#define MPIC_OK		0
> +#define MPIC_ERROR	1

What the heck are these for ?

Ben.

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3002DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 11:30:22 +1100 (EST)
In-Reply-To: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Wed, 21 Feb 2007 18:29:22 -0600
To: Stuart Yoder <b08248@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 21, 2007, at 5:25 PM, Stuart Yoder wrote:

>
> Added description of an interrupt-array property. This
> is needed to cleanly describe the interrupt properties
> of devices with interrupts routed to multiple
> interrupt controllers.
>
> Created a new section VII to describe interrupt
> representation in general and moved Section VI #2
> ('Specifiying interrupt information for SOC devices')
> to this new section.
>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---

what problem is this trying to solve?

- k

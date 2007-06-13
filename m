Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73AE0DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:56:02 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890D2AC84@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890D2AC84@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4470838fec2256a98e512486f8486605@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 09:55:56 +0200
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It will be good if you do:
> +				printk (KERN_EMERG "Error: reset
> control"
> +					"register not mapped,
> spinning!\n");
>
> Instead of:
> +				printk (KERN_EMERG "Error: reset control
> \
> +					register not mapped,
> spinning!\n");

Except you forgot a space.  Too much whitespace in the
resulting string is bad, but too little doesn't help
either ;-)


Segher

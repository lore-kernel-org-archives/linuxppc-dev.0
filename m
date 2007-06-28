Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C649DDFC3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:22:22 +1000 (EST)
In-Reply-To: <11829333481977-git-send-email-wei.zhang@freescale.com>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5f0438212493766009684d63e41c85cc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5 v2] Add the explanation and a sample of RapidIO DTS
	sector to the document of booting-without-of.txt file.
Date: Thu, 28 Jun 2007 11:22:14 +0200
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +    - #address-cells : Address representation for "rapidio" devices.
> +      This field represents the number of cells needed to represent
> +      the RapidIO address of the registers.  For supporting more than
> +      32-bits RapidIO address, this field should be <2>.
> +      See 1) above for more details on defining #address-cells.

What does the RapidIO standard say about number of address
bits?  You want to follow that, so all RapidIO devices can
use the same #address-cells, not just the FSL ones.  Also,
are there different kinds of address spaces on the bus, or
is it just one big memory-like space?


Segher

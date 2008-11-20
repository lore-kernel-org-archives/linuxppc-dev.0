Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8C03DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:32:42 +1100 (EST)
Message-Id: <644D289D-7057-44F4-B444-E60402E06912@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200811201332.24061.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 20 Nov 2008 09:32:21 -0600
References: <200811201332.24061.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 20, 2008, at 6:32 AM, Laurent Pinchart wrote:

> Instead of rounding the divider down, improve the baud-rate generators
> accuracy by rounding to the nearest integer.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> arch/powerpc/sysdev/cpm2.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

is this fixing a bug or just making things better?

- k

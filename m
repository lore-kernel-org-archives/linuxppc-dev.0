Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2751EDE6D0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 01:54:49 +1100 (EST)
In-Reply-To: <200803261344.26555.laurentp@cse-semaphore.com>
References: <200803261344.26555.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d195a61e876d685ea04b29474da187cc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] Describe memory-mapped RAM&ROM chips of
	bindings
Date: Wed, 26 Mar 2008 15:52:37 +0100
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +    Dedicated RAM and ROM chips are often used as storage for 
> temporary or
> +    permanent data in embedded devices. Possible usage include 
> non-volatile
> +    storage in battery-backed SRAM, semi-permanent storage in 
> dedicated SRAM
> +    to preserve data accross reboots and firmware storage in 
> dedicated ROM.
> +
> +     - compatible : should contain the specific model of RAM/ROM 
> chip(s)
> +       used, if known, followed by either "physmap-ram" or 
> "physmap-rom"
> +     - reg : Address range of the RAM/ROM chip
> +     - bank-width : Width (in bytes) of the RAM/ROM bank. Equal to the
> +       device width times the number of interleaved chips.
> +     - device-width : (optional) Width of a single RAM/ROM chip. If
> +       omitted, assumed to be equal to 'bank-width'.

Maybe I'm rehashing some old discussion here, if so, sorry; but why
do you have bank-width and device-width here?  What useful information
does it provide?  If this is about saying what the preferred (or only
possible) access width is, better names are in order.


Segher

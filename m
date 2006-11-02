Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C25DC67C6A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 00:36:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA2DaXlx002563
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Nov 2006 08:36:33 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA2DaVBE189280
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Nov 2006 06:36:31 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA2DaU94022875
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Nov 2006 06:36:31 -0700
Subject: Re: [PATCH] adding ROM chips to device tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Vitaly Wool <vwool@ru.mvista.com>
In-Reply-To: <20061102145539.f0b8657f.vwool@ru.mvista.com>
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 07:30:37 -0600
Message-Id: <1162474237.11351.7.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 14:55 +0300, Vitaly Wool wrote:
> In fact, currently this description can handle only flash devices mapped into memory in a linear way.
>  For NAND flashes we'll need a whole lot different description but let's solve problems as they arise
>  since I'm not aware of any ppc board w/ NAND chip yet :)

Um...  all of the 440EP and 440EPx boards have NAND.  And those have
been around for a while...

> +
> +    Required properties:
> +
> +     - device_type : has to be "rom"

Why "rom" instead of "NOR"?

> +     - compatible : Should be the name of the MTD driver. Currently, this is
> +       most likely to be "physmap".
> +     - reg : Offset and length of the register set for the device.

reg doesn't really describe a register set here.  It's the overall
memory space for flash.

> +
> +    Recommended properties :
> +
> +     - bank-width : Width of the flash data bus in bytes. Must be specified
> +       for the NOR flashes.

This is a required property, not a recommended one.

josh

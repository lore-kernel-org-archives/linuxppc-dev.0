Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10FE7DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 10:34:11 +1100 (EST)
Message-ID: <47AB956D.4090805@freescale.com>
Date: Thu, 07 Feb 2008 17:34:05 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [libfdt] RFC: Node iterators (v2)
References: <20080116062022.GD5016@localhost.localdomain>
	<20080117051009.GA12239@localhost.localdomain>
In-Reply-To: <20080117051009.GA12239@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> And here's a revised version.  This now also handles recursive
> iteration and iteration across nodes without respect to depth.  I've
> removed the for_each() macros for the time being, because they were
> making my brain hurt, but I'm still contemplating bringing them back.
> Several libfdt functions are now implemented using the new iterator,
> so this ends up as a code-size-reducing patch.
> 
> I'm pretty happy with the basic outline of this now, although the
> names and details might want a bit of polish still.

Can we get this merged?

> +int _fdt_next_node(const void *fdt, int offset, int *depth)
> +{

This is a public function; why the underscore?

-Scott

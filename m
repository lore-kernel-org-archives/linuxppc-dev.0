Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.co.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id D685567A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 02:57:00 +1000 (EST)
Message-ID: <425171C8.5010709@jonmasters.org>
Date: Mon, 04 Apr 2005 17:56:41 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
References: <20050404164545.E603CC108D@atlas.denx.de>
	<42517236.70707@ru.mvista.com>
In-Reply-To: <42517236.70707@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys
	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:

> Wolfgang Denk wrote:

>> Who said this, and where? I am not aware of such a discussion.

> These are just plans:
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017561.html
> 
> -------- Original Message --------
> Subject: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys model...]
> Date: Thu, 31 Mar 2005 09:55:42 -0600
> From: Jon Loeliger <jdl@freescale.com>
> 
> <snip>
> Oh, yeah.  Um, also on my plate will be to construct the
> original flat-tree blob in U-Boot to be handed to the kernel.
> (I'll start with 85xx and 83xx, naturlich.)
> -------- End Original Message --------

The magic bit will be when we have automatic SYSTEM.MHS -> FlatOF BLOB 
on stuff like Virtex. That'll assist in doing away with the HAL :-)

Jon.

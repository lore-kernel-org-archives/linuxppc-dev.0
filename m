Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA1AFDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 02:52:14 +1000 (EST)
Message-ID: <46DD8D34.6000102@freescale.com>
Date: Tue, 04 Sep 2007 11:52:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Regarding immap_86xx.h
References: <12472670.post@talk.nabble.com>
	<706FA05F-6E3E-4A9C-9DB0-52840E178F06@kernel.crashing.org>
In-Reply-To: <706FA05F-6E3E-4A9C-9DB0-52840E178F06@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sivaji <rameshmrm@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Its most likely been removed since these structures have been  
> distributed to the places they are used.

Not only that, but I submitted a patch to remove the PCI structure, so all 
that's left is the GUTS structure.

The GUTS structure is different from other devices since it contains registers 
used by a variety of devices.  It's a sort of catch-all for miscellaneous 
hardware configuration.  That's why there's no GUTS device driver, and why I 
left the structure in immap_86xx.h.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

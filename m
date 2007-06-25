Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50445DDEFD
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 01:07:32 +1000 (EST)
Message-ID: <467FDA2C.8020607@freescale.com>
Date: Mon, 25 Jun 2007 10:07:24 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx, and
	86xx device trees
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
In-Reply-To: <70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Shouldn't you use the "??" notation instead, or is that
> still not implemented?

I just tested the very latest dtc, and it does not support ??.

> [I would have preferred if you had removed "address" right
> away (replaced by "mac-address"), but since it is marked
> for removal anyway, that's fine with me].

My initial patch removed address and mac-address, but Kumar reminded me that we don't want 
to break things so quickly.  I didn't want to run any regression tests on all these 
platforms and versions to see which obsolete properties could be removed from which DTS.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

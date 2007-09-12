Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DFC2DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 05:48:16 +1000 (EST)
Message-ID: <46E84274.2080401@freescale.com>
Date: Wed, 12 Sep 2007 14:48:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] ucc_geth: fix compilation
References: <20070912112456.GA15556@localhost.localdomain>
In-Reply-To: <20070912112456.GA15556@localhost.localdomain>
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

Anton Vorontsov wrote:
> This patch is against paulus/powerpc.git or galak/powerpc.git tree.
> Both affected.

Acked-by: Timur Tabi <timur@freescale.com>

This is an important fix.  Without it, 836x and 832x won't build.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

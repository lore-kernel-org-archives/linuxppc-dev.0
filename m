Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48768DDF43
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:05:47 +1000 (EST)
Message-ID: <4613E8F2.8030104@freescale.com>
Date: Wed, 04 Apr 2007 13:05:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
In-Reply-To: <4613E7CC.1020001@246tNt.com>
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

Sylvain Munaut wrote:

> Since the case where you manage offset is more common, it make senses to
> change the types to unsigned long. However the other usage model (manage
> addresses) should still be possible (using type casts only).

You'll have to explain to me how this works.  None of the current users of rheap operate 
in this way.  They all take the return value and cast them to unsigned ints/longs and then 
use them as an offset into the buffer.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

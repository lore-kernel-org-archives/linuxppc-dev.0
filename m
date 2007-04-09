Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A467DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 07:25:13 +1000 (EST)
Message-ID: <461AAF2F.2020608@freescale.com>
Date: Mon, 09 Apr 2007 16:25:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, pantelis.antoniou@gmail.com, tnt@246tNt.com,
	galak@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
References: <11757244213581-git-send-email-timur@freescale.com>
In-Reply-To: <11757244213581-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The rheap allocation functions return a pointer, but the actual value is based
> on how the heap was initialized, and so it can be anything, e.g. an offset
> into a buffer.  A ulong is a better representation of the value returned by
> the allocation functions.

No comments on this patch?  Does this mean that you all think it's okay for 2.6.22?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
